import 'package:flutter/material.dart';

enum ScaleType { linear, logarithmic, reversed }

class CurveConfig {
  final String mnemonic;
  final String unit;
  final double min;
  final double max;
  final Color color;
  final ScaleType scaleType;
  final bool isDashed;

  CurveConfig({
    required this.mnemonic,
    required this.unit,
    required this.min,
    required this.max,
    required this.color,
    this.scaleType = ScaleType.linear,
    this.isDashed = false,
  });
}

class TrackConfig {
  final String title;
  final List<CurveConfig> curves;

  TrackConfig({required this.title, required this.curves});
}

class LogDataPoint {
  final double depth;
  final double value;

  LogDataPoint(this.depth, this.value);
}
