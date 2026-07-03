import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/data/las_parser.dart';

class MultiTrackPlot extends StatelessWidget {
  final LasData lasData;
  final Map<String, List<double>> results;

  const MultiTrackPlot({Key? key, required this.lasData, required this.results})
    : super(key: key);

  List<FlSpot> _getCurveSpots(List<double> curve, List<double> depth) {
    List<FlSpot> spots = [];
    int step = (curve.length / 800).ceil();
    if (step < 1) step = 1;
    for (int i = 0; i < curve.length; i += step) {
      if (i < depth.length && !curve[i].isNaN && !depth[i].isNaN) {
        spots.add(FlSpot(curve[i], -depth[i]));
      }
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    List<double> depth = lasData.getCurve('DEPT');
    if (depth.isEmpty) return const Center(child: Text('No DEPT curve found.'));

    List<double> gr = lasData.getCurve('GR');
    List<double> ild = lasData.getCurve('ILD');

    List<double> vcl = results['VCL'] ?? [];
    List<double> phie = results['PHIE'] ?? [];
    List<double> swa = results['SWa'] ?? [];

    double minDepth = depth.first;
    double maxDepth = depth.last;

    double minY = -maxDepth;
    double maxY = -minDepth;

    return Row(
      children: [
        // Track 1: GR
        Expanded(
          child: _buildTrack(
            context,
            title: 'Gamma Ray (API)',
            minY: minY,
            maxY: maxY,
            minX: 0,
            maxX: 150,
            lines: [
              LineChartBarData(
                spots: _getCurveSpots(gr, depth),
                color: Colors.green,
                isCurved: false,
                barWidth: 1.2,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
        // Track 2: Resistivity
        Expanded(
          child: _buildTrack(
            context,
            title: 'Deep Resistivity (ohm.m)',
            minY: minY,
            maxY: maxY,
            minX: 0.1,
            maxX: 100,
            lines: [
              LineChartBarData(
                spots: _getCurveSpots(ild, depth),
                color: Colors.red,
                isCurved: false,
                barWidth: 1.2,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
        // Track 3: Results
        Expanded(
          flex: 2,
          child: _buildTrack(
            context,
            title: 'Interpretation (VCL, PHIE, SWa)',
            minY: minY,
            maxY: maxY,
            minX: 0,
            maxX: 1,
            lines: [
              LineChartBarData(
                spots: _getCurveSpots(vcl, depth),
                color: const Color(0xFF10b981), // emerald
                isCurved: false,
                barWidth: 1.2,
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: _getCurveSpots(phie, depth),
                color: Colors.white70,
                isCurved: false,
                barWidth: 1.2,
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: _getCurveSpots(swa, depth),
                color: const Color(0xFF3b82f6), // blue
                isCurved: false,
                barWidth: 1.2,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrack(
    BuildContext context, {
    required String title,
    required double minY,
    required double maxY,
    required double minX,
    required double maxX,
    required List<LineChartBarData> lines,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor.withOpacity(0.5),
              border: Border(bottom: BorderSide(color: theme.dividerColor)),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 24.0, 16.0),
              child: LineChart(
                LineChartData(
                  minY: minY,
                  maxY: maxY,
                  minX: minX,
                  maxX: maxX,
                  lineBarsData: lines,
                  titlesData: FlTitlesData(
                    bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Text(
                              (-value).toInt().toString(),
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white38,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: theme.dividerColor),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: theme.dividerColor.withOpacity(0.5),
                      strokeWidth: 1,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: theme.dividerColor.withOpacity(0.5),
                      strokeWidth: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
