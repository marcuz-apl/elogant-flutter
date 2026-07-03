import 'dart:math';

class DataWrangle {
  /// Aligns two curves by depth. If a depth point in curve B doesn't match curve A exactly,
  /// it could interpolate, but standard LAS files usually share the same depth index.
  /// For this MVP, we assume curves from the same LAS file share the same depth index.

  /// Applies a simple moving average to despike or smooth a curve
  static List<double> rollingMean(List<double> data, int windowSize) {
    if (data.isEmpty) return [];
    List<double> result = List.filled(data.length, double.nan);
    int halfWindow = windowSize ~/ 2;

    for (int i = 0; i < data.length; i++) {
      double sum = 0;
      int count = 0;
      for (
        int j = max(0, i - halfWindow);
        j <= min(data.length - 1, i + halfWindow);
        j++
      ) {
        if (!data[j].isNaN) {
          sum += data[j];
          count++;
        }
      }
      result[i] = count > 0 ? sum / count : double.nan;
    }
    return result;
  }
}
