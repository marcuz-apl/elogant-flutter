import 'dart:math';

enum VclCorrection { linear, larionovYoung, larionovOld, clavier, steiber }

class VolumeOfClay {
  /// Calculates Volume of Clay using Gamma Ray
  static double fromGR(
    double grLog,
    double grClean,
    double grClay, {
    VclCorrection correction = VclCorrection.linear,
  }) {
    if (grLog.isNaN) return double.nan;
    if (grClay == grClean) return double.nan;

    double igr = (grLog - grClean) / (grClay - grClean);
    igr = igr.clamp(0.0, 1.0); // Cap IGR between 0 and 1

    switch (correction) {
      case VclCorrection.larionovYoung:
        return 0.083 * (pow(2, 3.7 * igr) - 1);
      case VclCorrection.larionovOld:
        return 0.33 * (pow(2, 2 * igr) - 1);
      case VclCorrection.clavier:
        return 1.7 - sqrt(3.38 - pow((igr + 0.7), 2));
      case VclCorrection.steiber:
        return 0.5 * igr / (1.5 - igr);
      case VclCorrection.linear:
      default:
        return igr;
    }
  }

  /// Calculates Volume of Clay using Spontaneous Potential
  static double fromSP(double spLog, double spClean, double spClay) {
    if (spLog.isNaN) return double.nan;
    if (spClay == spClean) return double.nan;

    double vcl = (spLog - spClean) / (spClay - spClean);
    return vcl.clamp(0.0, 1.0);
  }

  /// Calculates Volume of Clay using Resistivity
  static double fromRT(double rtLog, double rtClean, double rtClay) {
    if (rtLog.isNaN) return double.nan;
    if (rtLog == 0 || rtClean == rtClay) return double.nan;

    double vrt = (rtClay / rtLog) * (rtClean - rtLog) / (rtClean - rtClay);

    if (rtLog > 2 * rtClay) {
      vrt = 0.5 * pow(2 * vrt, 0.67 * (vrt + 1));
    }
    return vrt.clamp(0.0, 1.0);
  }

  /// Calculates Volume of Clay using Neutron-Density crossplot
  static double fromND(
    double neutLog,
    double denLog,
    double neutClean1,
    double denClean1,
    double neutClean2,
    double denClean2,
    double neutClay,
    double denClay,
  ) {
    if (neutLog.isNaN || denLog.isNaN) return double.nan;

    double term1 =
        (denClean2 - denClean1) * (neutLog - neutClean1) -
        (denLog - denClean1) * (neutClean2 - neutClean1);
    double term2 =
        (denClean2 - denClean1) * (neutClay - neutClean1) -
        (denClay - denClean1) * (neutClean2 - neutClean1);

    if (term2 == 0) return double.nan;
    double vcl = term1 / term2;
    return vcl.clamp(0.0, 1.0);
  }
}
