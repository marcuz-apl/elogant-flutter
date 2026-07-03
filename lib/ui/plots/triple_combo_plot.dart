import 'dart:convert';
import 'package:flutter/material.dart';
import '../../database/database.dart';
import 'models.dart';
import 'track_header.dart';
import 'track_painter.dart';

class TripleComboPlot extends StatefulWidget {
  final AppDatabase database;
  final String wellName;

  const TripleComboPlot({
    Key? key,
    required this.database,
    required this.wellName,
  }) : super(key: key);

  @override
  State<TripleComboPlot> createState() => _TripleComboPlotState();
}

class _TripleComboPlotState extends State<TripleComboPlot> {
  bool _isLoading = true;
  List<double> _depths = [];
  Map<String, List<double>> _curveData = {};
  double _minDepth = 0;
  double _maxDepth = 1000; // Will be updated dynamically

  late List<TrackConfig> _trackConfigs;

  @override
  void initState() {
    super.initState();
    _setupConfigs();
    _loadData();
  }

  void _setupConfigs() {
    _trackConfigs = [
      TrackConfig(
        title: 'Lithology',
        curves: [
          CurveConfig(
            mnemonic: 'GR',
            unit: 'api',
            min: 0,
            max: 150,
            color: Colors.green,
          ),
          CurveConfig(
            mnemonic: 'CALI',
            unit: 'in',
            min: 10,
            max: 35,
            color: Colors.black,
            isDashed: true,
          ),
          CurveConfig(
            mnemonic: 'SP',
            unit: 'mV',
            min: -100,
            max: 0,
            color: Colors.blue,
          ),
        ],
      ),
      TrackConfig(
        title: 'Resistivity',
        curves: [
          CurveConfig(
            mnemonic: 'ILD',
            unit: 'm.ohm',
            min: 0.1,
            max: 100,
            color: Colors.red,
            scaleType: ScaleType.logarithmic,
          ),
          CurveConfig(
            mnemonic: 'ILM',
            unit: 'm.ohm',
            min: 0.1,
            max: 100,
            color: Colors.purple,
            scaleType: ScaleType.logarithmic,
          ),
          CurveConfig(
            mnemonic: 'LL8',
            unit: 'm.ohm',
            min: 0.1,
            max: 100,
            color: Colors.black,
            scaleType: ScaleType.logarithmic,
          ),
        ],
      ),
      TrackConfig(
        title: 'Porosity/Sonic',
        curves: [
          CurveConfig(
            mnemonic: 'RHOB',
            unit: 'g/cc',
            min: 2.0,
            max: 2.8,
            color: Colors.red,
          ),
          CurveConfig(
            mnemonic: 'NPHI',
            unit: '%',
            min: -10,
            max: 40,
            color: Colors.green,
            scaleType: ScaleType.reversed,
          ),
          CurveConfig(
            mnemonic: 'DT',
            unit: 'us/ft',
            min: 40,
            max: 140,
            color: Colors.blue,
            scaleType: ScaleType.reversed,
          ),
        ],
      ),
    ];
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final logs = await (widget.database.select(
        widget.database.lasLogData,
      )..where((tbl) => tbl.wellName.equals(widget.wellName))).get();

      Map<String, List<double>> parsedData = {};

      for (var log in logs) {
        List<dynamic> jsonList = jsonDecode(log.dataJson);
        List<double> doubleList = jsonList
            .map((e) => (e as num).toDouble())
            .toList();
        parsedData[log.mnemonic] = doubleList;
      }

      // Try to find the depth curve flexibly
      String? depthKey;
      for (var key in parsedData.keys) {
        final normalized = key.trim().toUpperCase();
        if (normalized == 'DEPT' ||
            normalized == 'DEPTH' ||
            normalized == 'M__DEPTH' ||
            normalized == 'MD') {
          depthKey = key;
          break;
        }
      }

      List<double>? depthData = depthKey != null ? parsedData[depthKey] : null;

      if (depthData != null && depthData.isNotEmpty) {
        _depths = depthData;
        _curveData = parsedData;
        _minDepth = depthData.reduce((a, b) => a < b ? a : b);
        _maxDepth = depthData.reduce((a, b) => a > b ? a : b);
      } else {
        print(
          'Error: Could not find DEPT or DEPTH curve. Available curves: ${parsedData.keys.toList()}',
        );
      }
    } catch (e) {
      print('Error loading plot data: $e');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_depths.isEmpty) {
      return const Center(
        child: Text('No Depth data available for this well.'),
      );
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Well Composite',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Row(
            children: _trackConfigs.map((config) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Column(
                    children: [
                      TrackHeader(config: config),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return ClipRect(
                              child: InteractiveViewer(
                                constrained: false,
                                boundaryMargin: const EdgeInsets.all(0),
                                minScale: 1.0,
                                maxScale: 5.0,
                                child: SizedBox(
                                  width: constraints.maxWidth,
                                  height: (_maxDepth - _minDepth) * 2.0,
                                  child: CustomPaint(
                                    painter: TrackPainter(
                                      depths: _depths,
                                      curveData: _curveData,
                                      config: config,
                                      minDepth: _minDepth,
                                      maxDepth: _maxDepth,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
