# Petrophysical Domain Rules

## Data Handling & Wrangling
- **Robust Dart Translation:** Without Pandas, ensure robust custom Dart classes are created for curve data series handling, depth alignment, and missing value interpolation.
- **Curve Math:** All curve math must handle null values properly (e.g., using `-999.25` or `NaN` per LAS standards).

## Nomenclature & Naming Conventions
- Adhere strictly to industry standard naming conventions for well logs:
  - `GR`: Gamma Ray
  - `SP`: Spontaneous Potential
  - `NPHI` / `PHIN`: Neutron Porosity
  - `RHOB` / `ZDEN`: Bulk Density
  - `RT` / `LLD`: Deep Resistivity
  - `CALI`: Caliper
- Calculated curves should use standard abbreviations:
  - `VCL`: Volume of Clay
  - `PHIE`: Effective Porosity
  - `PHIT`: Total Porosity
  - `SW`: Water Saturation
  - `BVW`: Bulk Volume Water

## Calculation Standards
- **VCL Models:** Implement Linear, Larionov (Tertiary & Older Rocks), Steiber, and Clavier.
- **Porosity Models:** Implement Density-Neutron crossplot porosity, sonic porosity, and density porosity.
- **Saturation Models:** Implement Archie, Simandoux, and Indonesian models. All parameters ($a, m, n, Rw$) must be configurable by the user.
