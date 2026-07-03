import 'package:flutter/material.dart';
import '../visualization/multi_track_plot.dart';

class AnalysisView extends StatelessWidget {
  final ThemeData theme;
  final bool hasData;
  final Map<String, List<double>>? results;
  final dynamic lasData;

  const AnalysisView({
    Key? key,
    required this.theme,
    required this.hasData,
    this.results,
    this.lasData,
  }) : super(key: key);

  Widget _buildMetricCard(
    String title,
    String value,
    String unit, {
    Color? valueColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: valueColor ?? Colors.white,
                  ),
                ),
                if (unit.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!hasData) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.layers,
              size: 48,
              color: theme.colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to Elogant Workspace',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'To begin processing log datasets, load a LAS file from the registry.',
              style: TextStyle(fontSize: 13, color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          // Quality Metrics Cards
          if (results != null)
            Row(
              children: [
                _buildMetricCard('Gross Interval', '405.0', 'ft'),
                const SizedBox(width: 16),
                _buildMetricCard('Net Sand Thickness', '210.5', 'ft'),
                const SizedBox(width: 16),
                _buildMetricCard('Net Reservoir Thickness', '180.2', 'ft'),
                const SizedBox(width: 16),
                _buildMetricCard(
                  'Net Pay Thickness',
                  '45.8',
                  'ft',
                  valueColor: Colors.orange,
                ), // using orange for gradient mock
                const SizedBox(width: 16),
                _buildMetricCard(
                  'Net-to-Gross (NTG)',
                  '0.520',
                  '',
                  valueColor: Colors.orange,
                ),
              ],
            ),

          if (results != null) const SizedBox(height: 24),

          // Main Logging Charts
          if (results != null)
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Logging Charts: Imp\'d + interp\'d (Depth: ft)',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          border: Border.all(
                            color: theme.dividerColor.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Top Well Depth: 100 ft | Bottom Depth: 5000 ft',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: theme.dividerColor.withOpacity(0.3),
                    height: 1,
                  ),
                  const SizedBox(height: 16),

                  // The actual MultiTrackPlot
                  SizedBox(
                    height: 700,
                    child: MultiTrackPlot(lasData: lasData!, results: results!),
                  ),
                ],
              ),
            ),

          if (results != null) const SizedBox(height: 24),

          // Pickett Plot and Pay Zone Metrics
          if (results != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickett Plot Area
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: theme.cardColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.dividerColor.withOpacity(0.3),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pickett Crossover Crossplot (Clean Sands)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          color: theme.dividerColor.withOpacity(0.3),
                          height: 1,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Pickett Plot CustomPainter Mock',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Mean Properties & Export
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: theme.cardColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.dividerColor.withOpacity(0.3),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mean Pay Zone Properties',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: theme.dividerColor.withOpacity(0.3),
                              height: 1,
                            ),
                            const SizedBox(height: 16),
                            _buildPayMetric('Clay Volume (VCL)', '12.4 %'),
                            _buildPayMetric(
                              'Effective Porosity (PHIE)',
                              '24.1 %',
                            ),
                            _buildPayMetric('Water Saturation (Sw)', '35.8 %'),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.picture_as_pdf,
                                  size: 16,
                                ),
                                label: const Text('Download Full PDF Report'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.download, size: 16),
                                label: const Text(
                                  'Export Processed Data to CSV',
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  side: BorderSide(color: theme.dividerColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPayMetric(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
