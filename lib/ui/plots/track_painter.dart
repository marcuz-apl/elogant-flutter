import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'models.dart';

class TrackPainter extends CustomPainter {
  final List<double> depths;
  final Map<String, List<double>> curveData; // Map of mnemonic to data
  final TrackConfig config;
  final double minDepth;
  final double maxDepth;

  TrackPainter({
    required this.depths,
    required this.curveData,
    required this.config,
    required this.minDepth,
    required this.maxDepth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (depths.isEmpty || minDepth >= maxDepth) return;

    // Draw horizontal grid lines (every 50 depth units for example)
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.0;

    double depthRange = maxDepth - minDepth;

    // Grid logic:
    double gridStep = 50.0;
    double firstGrid = (minDepth / gridStep).ceil() * gridStep;
    for (double d = firstGrid; d <= maxDepth; d += gridStep) {
      double y = ((d - minDepth) / depthRange) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);

      // Depth labels on the left of the track if it's the first track (or handled outside)
      // We will handle depth labels outside the painter, or on the left border.
    }

    // Draw Vertical grid lines (e.g. 10 divisions)
    for (int i = 0; i <= 10; i++) {
      double x = (i / 10) * size.width;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Draw each curve
    for (var curveConfig in config.curves) {
      if (!curveData.containsKey(curveConfig.mnemonic)) continue;

      final data = curveData[curveConfig.mnemonic]!;
      final paint = Paint()
        ..color = curveConfig.color
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      // Handle dashed lines manually (simple implementation: skip drawing if we need dashed)
      // A more robust implementation would use a Path metric, but for now we draw a solid path
      // or we can draw small segments for dashes.

      Path path = Path();
      bool isFirst = true;

      for (int i = 0; i < data.length; i++) {
        if (i >= depths.length) break;
        double val = data[i];
        double depth = depths[i];

        // Skip null/invalid values (e.g., -999.25)
        if (val.isNaN || val == -999.25 || val == -9999.0) {
          isFirst = true;
          continue;
        }

        double y = ((depth - minDepth) / depthRange) * size.height;
        double x = 0;

        if (curveConfig.scaleType == ScaleType.linear) {
          x =
              ((val - curveConfig.min) / (curveConfig.max - curveConfig.min)) *
              size.width;
        } else if (curveConfig.scaleType == ScaleType.reversed) {
          x =
              size.width -
              (((val - curveConfig.min) / (curveConfig.max - curveConfig.min)) *
                  size.width);
        } else if (curveConfig.scaleType == ScaleType.logarithmic) {
          // Log10 scale mapping
          double safeVal = max(val, curveConfig.min);
          double logMin = log(curveConfig.min) / ln10;
          double logMax = log(curveConfig.max) / ln10;
          double logVal = log(safeVal) / ln10;

          x = ((logVal - logMin) / (logMax - logMin)) * size.width;
        }

        // Clamp X to bounds visually
        x = x.clamp(0.0, size.width);

        if (isFirst) {
          path.moveTo(x, y);
          isFirst = false;
        } else {
          path.lineTo(x, y);
        }
      }

      if (curveConfig.isDashed) {
        // Simple dashed implementation using extractPath
        Path dashPath = Path();
        for (PathMetric metric in path.computeMetrics()) {
          double distance = 0.0;
          while (distance < metric.length) {
            dashPath.addPath(
              metric.extractPath(distance, distance + 10),
              Offset.zero,
            );
            distance += 20; // 10 on, 10 off
          }
        }
        canvas.drawPath(dashPath, paint);
      } else {
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant TrackPainter oldDelegate) {
    return oldDelegate.minDepth != minDepth || oldDelegate.maxDepth != maxDepth;
  }
}
