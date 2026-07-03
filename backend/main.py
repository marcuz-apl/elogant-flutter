import io
import math
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg') # Use non-interactive backend
import matplotlib.pyplot as plt
from fastapi import FastAPI, UploadFile, File, Form
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, StreamingResponse
import lasio

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Helpers for petrophysics
def vclgr(gr_log, gr_clean, gr_clay):
    igr = (gr_log - gr_clean) / (gr_clay - gr_clean)
    return igr

def phis_w(dt_log, dt_ma, dt_fl, cp):
    return (1/cp)*(dt_log - dt_ma)/(dt_fl - dt_ma)

def phis_w_sh_corr(dt_log, dt_ma, dt_fl, cp, dt_sh, vcl):
    phis_w_val = phis_w(dt_log, dt_ma, dt_fl, cp)
    phis_w_sh = (dt_sh - dt_ma)/(dt_fl - dt_ma)
    return phis_w_val - vcl * phis_w_sh

def phid(den_log, den_ma, den_fl, den_sh, vcl):
    return (den_log - den_ma) / (den_fl - den_ma)

def phid_sh_corr(den, den_ma, den_fl, den_sh, vcl):
    phid_val = (den - den_ma) / (den_fl - den_ma)
    phid_sh = (den_sh - den_ma) / (den_fl - den_ma)
    return phid_val - vcl * phid_sh

def phin_sh_corr(neut, neut_sh, vcl):
    return (neut - vcl*neut_sh)/100

def phixnd(phinshc, phidshc):
    return (phinshc + phidshc) / 2

def sw_archie(Rw, Rt, Poro, a, m, n):
    # Avoid division by zero
    Poro = np.where(Poro <= 0.001, 0.001, Poro)
    Rt = np.where(Rt <= 0.001, 0.001, Rt)
    F = a / (Poro**m)
    return (F * Rw / Rt)**(1/n)

def run_petrophysics(df: pd.DataFrame):
    # Rename M__DEPTH to DEPT if necessary
    if 'M__DEPTH' in df.columns:
        df = df.rename(columns={'M__DEPTH': 'DEPT'})
    if 'DEPT' not in df.columns and df.index.name in ['DEPT', 'DEPTH', 'M__DEPTH']:
        df['DEPT'] = df.index
    
    # Constants
    gr_clean, gr_clay = 40.0, 135.0
    dt_ma, dt_fl, dt_sh, cp = 55.5, 188.0, 90.0, 1
    den_ma, den_fl, den_sh = 2.65, 1.1, 2.4
    phin_sh = 45.0
    a, m, n = 1.0, 1.8, 2.0
    rwa = 0.45

    if 'GR' in df.columns:
        df['VCL'] = vclgr(df['GR'], gr_clean, gr_clay).clip(0, 1)
    else:
        df['VCL'] = 0.0

    if 'DT' in df.columns:
        df['PHISwshc'] = phis_w_sh_corr(df['DT'], dt_ma, dt_fl, cp, dt_sh, df['VCL']).clip(0, 1)
    
    if 'RHOB' in df.columns:
        df['PHIDshc'] = phid_sh_corr(df['RHOB'], den_ma, den_fl, den_sh, df['VCL']).clip(0, 1)
    
    if 'NPHI' in df.columns:
        df['PHINshc'] = phin_sh_corr(df['NPHI'], phin_sh, df['VCL']).clip(0, 1)
    
    if 'PHINshc' in df.columns and 'PHIDshc' in df.columns:
        df['PHIE'] = phixnd(df['PHINshc'], df['PHIDshc']).clip(0, 1)
    else:
        df['PHIE'] = 0.1 # Fallback
        
    if 'ILD' in df.columns:
        df['SWa'] = sw_archie(rwa, df['ILD'], df['PHIE'], a, m, n).clip(0, 1)
    else:
        df['SWa'] = 1.0
        
    df['BVW'] = df['SWa'] * df['PHIE']
    return df

import base64

def generate_plot(df: pd.DataFrame) -> str:
    if 'DEPT' not in df.columns:
        df['DEPT'] = df.index
        
    logs = df
    top_depth = df['DEPT'].min()
    bottom_depth = df['DEPT'].max()

    fig, ax = plt.subplots(nrows=1, ncols=3, figsize=(10,12), sharey=True)
    fig.subplots_adjust(top=0.85, wspace=0.1)

    for axes in ax:
        axes.set_ylim(top_depth, bottom_depth)
        axes.invert_yaxis()
        axes.yaxis.grid(True)
        axes.get_xaxis().set_visible(False) 

    # 1st track: GR, CALI, SP
    if 'SP' in logs.columns:
        ax01 = ax[0].twiny()
        ax01.set_xlim(-100, 10)
        ax01.plot(logs.SP, logs.DEPT, label='SP[mV]', color='blue')
        ax01.set_xlabel('SP[mV]', color='blue')    
        ax01.tick_params(axis='x', colors='blue')
        ax01.grid(True)

    if 'CALI' in logs.columns:
        ax02 = ax[0].twiny()
        ax02.set_xlim(6, 36)
        ax02.plot(logs.CALI, logs.DEPT, '--', label='CALI[in]', color='black') 
        ax02.spines['top'].set_position(('outward', 40))
        ax02.set_xlabel('CALI[in]', color='black')    
        ax02.tick_params(axis='x', colors='black')

    if 'GR' in logs.columns:
        ax03 = ax[0].twiny()
        ax03.set_xlim(0, 150)
        ax03.plot(logs.GR, logs.DEPT, label='GR[api]', color='green') 
        ax03.spines['top'].set_position(('outward', 80))
        ax03.set_xlabel('GR[api]', color='green')    
        ax03.tick_params(axis='x', colors='green')

    # 2nd track: Resistivities
    if 'ILD' in logs.columns:
        ax11 = ax[1].twiny()
        ax11.set_xlim(0.1, 100)
        ax11.set_xscale('log')
        ax11.grid(True)
        ax11.plot(logs.ILD, logs.DEPT, label='ILD', color='red')
        ax11.set_xlabel('ILD', color='red')
        ax11.tick_params(axis='x', colors='red')

    if 'ILM' in logs.columns:
        ax12 = ax[1].twiny()
        ax12.set_xlim(0.1, 100)
        ax12.set_xscale('log')
        ax12.plot(logs.ILM, logs.DEPT, label='ILM', color='purple') 
        ax12.spines['top'].set_position(('outward', 40))
        ax12.set_xlabel('ILM', color='purple')    
        ax12.tick_params(axis='x', colors='purple')

    # 3rd track: Porosity/Sonic
    if 'DT' in logs.columns:
        ax21 = ax[2].twiny()
        ax21.grid(True)
        ax21.set_xlim(140, 40)
        ax21.plot(logs.DT, logs.DEPT, label='DT', color='blue')
        ax21.set_xlabel('DT', color='blue')    
        ax21.tick_params(axis='x', colors='blue')

    if 'NPHI' in logs.columns:
        ax22 = ax[2].twiny()
        ax22.set_xlim(-15, 45)
        ax22.invert_xaxis()
        ax22.plot(logs.NPHI, logs.DEPT, label='NPHI', color='green') 
        ax22.spines['top'].set_position(('outward', 40))
        ax22.set_xlabel('NPHI', color='green')    
        ax22.tick_params(axis='x', colors='green')

    if 'RHOB' in logs.columns:
        ax23 = ax[2].twiny()
        ax23.set_xlim(1.95, 2.95)
        ax23.plot(logs.RHOB, logs.DEPT, label='RHOB', color='red') 
        ax23.spines['top'].set_position(('outward', 80))
        ax23.set_xlabel('RHOB', color='red')
        ax23.tick_params(axis='x', colors='red')

    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=150, bbox_inches='tight')
    plt.close(fig)
    buf.seek(0)
    return base64.b64encode(buf.read()).decode('utf-8')

@app.post("/api/upload")
async def upload_las(file: UploadFile = File(...)):
    contents = await file.read()
    string_data = contents.decode("utf-8", errors="ignore")
    las = lasio.read(string_data)
    df = las.df()
    df = run_petrophysics(df)
    
    # Generate Plot
    plot_b64 = generate_plot(df)
    
    # Replace NaN/inf with None for JSON
    df = df.replace([np.inf, -np.inf, np.nan], None)
    
    mnemonics = list(df.columns)
    if df.index.name and df.index.name not in mnemonics:
        mnemonics.insert(0, df.index.name)
        
    df_reset = df.reset_index()
    
    return JSONResponse({
        "mnemonics": list(df_reset.columns),
        "data": df_reset.to_dict(orient='list'),
        "plot_image": plot_b64
    })
