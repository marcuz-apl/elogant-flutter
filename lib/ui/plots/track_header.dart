import 'package:flutter/material.dart';
import 'models.dart';

class TrackHeader extends StatelessWidget {
  final TrackConfig config;

  const TrackHeader({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 1.0)),
      ),
      child: Column(
        children: config.curves.map((curve) {
          return _buildCurveHeader(curve);
        }).toList(),
      ),
    );
  }

  Widget _buildCurveHeader(CurveConfig curve) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Text(
            '${curve.mnemonic}[${curve.unit}]',
            style: TextStyle(
              color: curve.color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                curve.scaleType == ScaleType.reversed
                    ? curve.max.toString()
                    : curve.min.toString(),
                style: TextStyle(color: curve.color, fontSize: 10),
              ),
              Text(
                curve.scaleType == ScaleType.reversed
                    ? curve.min.toString()
                    : curve.max.toString(),
                style: TextStyle(color: curve.color, fontSize: 10),
              ),
            ],
          ),
          // Draw axis line (solid or dashed)
          CustomPaint(
            size: const Size(double.infinity, 5),
            painter: _HeaderAxisPainter(
              curve.color,
              curve.isDashed,
              curve.scaleType == ScaleType.logarithmic,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAxisPainter extends CustomPainter {
  final Color color;
  final bool isDashed;
  final bool isLog;

  _HeaderAxisPainter(this.color, this.isDashed, this.isLog);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    if (isDashed) {
      double dashWidth = 4, dashSpace = 4, startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    }

    // Draw tick marks
    int ticks = isLog ? 4 : 10;
    for (int i = 0; i <= ticks; i++) {
      double x = (i / ticks) * size.width;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
