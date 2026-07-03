# Elogant Product Development Roadmap



## Intro and Vision

Elogant is a intelligent well logging and data interpretation platform, serving mainly in energy sector. It streamline operations with automated insights and highly accurate predictions.

The comparable products in the industry are:

- Schlumberger - Techlog

- Senergy - Interactive Petrophysics (IP)

- GeolOil - GeolOil

The product features:

- Advanced analytics and reporting capabilities

- Enterprise-grade security and compliance



## Development Objectives

To develop a easy-to-use, simple, but powerful, full-range Petrophysical analysis Webapp + macOS/Windows Desktop with sleek interface



## Function Design

Function wise, the `Elogant` suite includes:

- Data Loading: Typically LAS or Text (tab/comma/space-delimited) per Energy industry
- Initial Log presentation in tracks: at least 3 tracks, refer to the python code attached ipynb file.
- An function of data wrangle shall be developed: cleansing, de-spiking, merging, handling overlapping log intervals due to different hole size, etc.
- A Settings/Parameters window shall be in place prior to the calculation after.  
- A powerful engine to calculate VCL (or VSH), Porosity (Total PHIt and Effective PHIe), and Water Saturation (Sw)
- Plot function to display the original logs with the newly interpreted VCL, Porosities and Sw
- An engine to determine the Cut-offs of VCL, PHIe, and Sw, as per https://geoloil.com/petroCutoffs.php
- A module to calculate NetRock, NetReservoir, and NetPay, plus Net-to-Gross Ratio.
- A Final Plot and Reporting Module



## Development Requirements

- A Python codebase, in Jupyter Notebook format, is ready in the folder `./PetroFizik`, please read the README.md and go through Jupyter Notebook, Python scripts for how the Log Analysis is done in Energy Sector.
- Please advise the coding language.
- Please prepare and advise proper AGENTS.md and rules (such as: ./agents/reload.md) and install skills as needed.
- Please design a feasible functions/modules as per Section: Function Design above.
- Please advise your thoughts which I didn't mention here.
- The development shall be in step-by-step manner, not expecting finish nor be perfect in one shot. 