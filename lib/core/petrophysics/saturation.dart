import 'dart:math';

class Saturation {
  /// Archie's Water Saturation (Sw)
  /// Calculates the fraction of pore space filled with water.
  ///
  /// Rw: Water resistivity
  /// Rt: True formation resistivity (usually deep induction or laterolog)
  /// Poro: Porosity (fraction, e.g. 0.20)
  /// a: Tortuosity factor (usually 1.0)
  /// m: Cementation exponent (usually 2.0)
  /// n: Saturation exponent (usually 2.0)
  static double archie(
    double rw,
    double rt,
    double poro,
    double a,
    double m,
    double n,
  ) {
    if (rt.isNaN || poro.isNaN || poro <= 0 || rt <= 0) return double.nan;

    double f = a / pow(poro, m);
    double sw = pow((f * rw / rt), (1 / n)).toDouble();
    return sw.clamp(0.0, 1.0);
  }
}
