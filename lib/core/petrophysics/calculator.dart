import '../data/las_parser.dart';
import 'volume_of_clay.dart';
import 'porosity.dart';
import 'saturation.dart';

class PetrophysicsCalculator {
  static Map<String, List<double>> calculateAll(
    LasData data, {
    double grClean = 40.0,
    double grClay = 135.0,
    double spClean = -60.0,
    double spClay = 2.0,
    double neutClean1 = 15.0,
    double denClean1 = 2.6,
    double neutClean2 = 40.0,
    double denClean2 = 2.0,
    double neutClay = 47.5,
    double denClay = 2.8,
    double a = 1.0,
    double m = 1.8,
    double n = 2.0,
    double rwa = 0.45,
  }) {
    List<double> gr = data.getCurve('GR');
    List<double> sp = data.getCurve('SP');
    List<double> nphi = data.getCurve('NPHI');
    List<double> rhob = data.getCurve('RHOB');
    List<double> ild = data.getCurve('ILD');

    int length = gr.isNotEmpty
        ? gr.length
        : (nphi.isNotEmpty ? nphi.length : 0);

    List<double> vclGr = List.filled(length, double.nan);
    List<double> phie = List.filled(length, double.nan);
    List<double> swa = List.filled(length, double.nan);
    List<double> bvw = List.filled(length, double.nan);

    for (int i = 0; i < length; i++) {
      // 1. Volume of Clay (VCL)
      double currentGr = i < gr.length ? gr[i] : double.nan;
      vclGr[i] = VolumeOfClay.fromGR(
        currentGr,
        grClean,
        grClay,
        correction: VclCorrection.linear,
      );

      // 2. Porosity (PHIE) from Density-Neutron Crossplot
      double currentNphi = i < nphi.length ? nphi[i] : double.nan;
      double currentRhob = i < rhob.length ? rhob[i] : double.nan;

      double phinShc = Porosity.neutronShaleCorrected(
        currentNphi,
        45.0,
        vclGr[i],
      );
      double phidShc = Porosity.densityShaleCorrected(
        currentRhob,
        2.65,
        1.1,
        2.4,
        vclGr[i],
      );

      phie[i] = Porosity.neutronDensityCrossplot(phinShc, phidShc);

      // 3. Saturation (SWa)
      double currentIld = i < ild.length ? ild[i] : double.nan;
      swa[i] = Saturation.archie(rwa, currentIld, phie[i], a, m, n);

      // 4. Bulk Volume Water (BVW)
      if (!swa[i].isNaN && !phie[i].isNaN) {
        bvw[i] = swa[i] * phie[i];
      }
    }

    return {'VCL': vclGr, 'PHIE': phie, 'SWa': swa, 'BVW': bvw};
  }
}
