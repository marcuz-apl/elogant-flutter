# Alfazen PetroFizik: Basic-Well-Log-Interpretation



Version: 1.0.0-2025.12.25



## Intro

﻿The easy approach to make a quick interpretation of well logs using Python and some packages:

- `lasio`: for converting LAS file to Data Frame ready for Pandas to consume, 
- `matplotlib`: for plotting, 
- `pandas`: for data manipulating,
- `numpy`: for scientific calculation, and
- a few pre-defined petrophysical functions.

**Check the Jupyter notebook!**



## Procedures

### 1- Install Python Packages

```shell
pip install -r ./requirements.txt
```

### 2- Download the LAS File(s) from the source site(s)

```shell
wget -O ./data/new-name.LAS https://example.com/site/to/download/the/LAS/files/ 
```

### 3- Convert the LAS file to a text file with the pre-tuned Python Script

```shell﻿Logs can be finally exported to csv or excel !
python ./las2text-lasio.py
```

### 4- Read in the data in text/ASCII format

```shell
...
import pandas as pd
...
data = pd.read_table('./data/WA1.txt', sep=r'\s+', index_col='M__DEPTH')
...
```

### 5- Calculate VCL, PHIE, SW

```shell
## Function to Calculate VCL
...
## Function to calculate PHIE
...
## Function to calculate SW
...
```

### 6- Print the Interpretation Plot

```shell
## Function to plot the final interpretation
...
```

### 7- Summary

