import 'dart:math';

class Porosity {
  /// Sonic Porosity - Willie-TimeAverage
  static double sonicWillie(double dtLog, double dtMa, double dtFl, double cp) {
    if (dtLog.isNaN) return double.nan;
    return (1 / cp) * (dtLog - dtMa) / (dtFl - dtMa);
  }

  static double sonicWillieShaleCorrected(
    double dtLog,
    double dtMa,
    double dtFl,
    double cp,
    double dtSh,
    double vcl,
  ) {
    if (dtLog.isNaN || vcl.isNaN) return double.nan;
    double phisW = sonicWillie(dtLog, dtMa, dtFl, cp);
    double phisWSh = (dtSh - dtMa) / (dtFl - dtMa);
    return (phisW - vcl * phisWSh).clamp(0.0, 1.0);
  }

  /// Sonic Porosity - Raymer-Hunt-Gardner
  static double sonicRHG(double dtLog, double dtMa, double alpha) {
    if (dtLog.isNaN || dtLog == 0) return double.nan;
    return alpha * (dtLog - dtMa) / dtLog;
  }

  static double sonicRHGShaleCorrected(
    double dtLog,
    double dtMa,
    double dtSh,
    double dtFl,
    double vcl,
  ) {
    if (dtLog.isNaN || vcl.isNaN) return double.nan;
    double phisRhg = sonicRHG(dtLog, dtMa, 5 / 8); // 5/8 is the standard alpha
    double phisRhgSh = (dtSh - dtMa) / (dtFl - dtMa);
    return (phisRhg - vcl * phisRhgSh).clamp(0.0, 1.0);
  }

  /// Density Porosity
  static double density(double denLog, double denMa, double denFl) {
    if (denLog.isNaN) return double.nan;
    return (denLog - denMa) / (denFl - denMa);
  }

  static double densityShaleCorrected(
    double denLog,
    double denMa,
    double denFl,
    double denSh,
    double vcl,
  ) {
    if (denLog.isNaN || vcl.isNaN) return double.nan;
    double phid = density(denLog, denMa, denFl);
    double phidSh = (denSh - denMa) / (denFl - denMa);
    return (phid - vcl * phidSh).clamp(0.0, 1.0);
  }

  /// Neutron Porosity Shale Corrected
  static double neutronShaleCorrected(
    double neutLog,
    double neutSh,
    double vcl,
  ) {
    if (neutLog.isNaN || vcl.isNaN) return double.nan;
    // Note: Assuming neutLog is in percentage in the LAS file, divide by 100 as per python code
    return ((neutLog - vcl * neutSh) / 100).clamp(0.0, 1.0);
  }

  /// Neutron-Density Crossplot Porosity (Effective Porosity)
  static double neutronDensityCrossplot(double phinShc, double phidShc) {
    if (phinShc.isNaN || phidShc.isNaN) return double.nan;
    return ((phinShc + phidShc) / 2).clamp(0.0, 1.0);
  }

  /// Gas Corrected Neutron-Density
  static double neutronDensityGasCorrected(double phin, double phid) {
    if (phin.isNaN || phid.isNaN) return double.nan;
    return sqrt((pow(phin, 2) + pow(phid, 2)) / 2).clamp(0.0, 1.0);
  }
}
