import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'components/global_header.dart';
import 'components/global_footer.dart';
import 'components/sidebar.dart';
import '../database/database.dart';
import '../services/data_loader.dart';
import 'plots/triple_combo_plot.dart';
import 'views/data_loader_view.dart';
import 'views/wrangle_view.dart';
import 'views/analysis_view.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  const HomeScreen({Key? key, required this.database}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _lasData;
  Map<String, List<double>>? _results;
  bool _isLoading = false;
  String _activeWellFilename = '-- Select Well --';
  bool _rightPanelOpen = true;

  // View States
  bool _isDataLoaderOpen = true;
  bool _wrangleMode = false;
  bool _showTripleCombo = false;
  String? _plotImageBase64;

  late DataLoaderService _dataLoaderService;

  @override
  void initState() {
    super.initState();
    _dataLoaderService = DataLoaderService(widget.database);
  }

  // Calculation parameters
  double _grClean = 40.0;
  double _grClay = 135.0;
  double _rw = 0.45;
  double _aConst = 1.0;
  double _mConst = 1.8;
  double _nConst = 2.0;
  double _vclCutoff = 0.40;
  double _phieCutoff = 0.10;
  double _swCutoff = 0.50;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['las', 'txt'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final platformFile = result.files.single;
        String contents;

        if (kIsWeb) {
          contents = String.fromCharCodes(platformFile.bytes!);
        } else {
          File file = File(platformFile.path!);
          contents = await file.readAsString();
        }

        String wellNameWithoutExt = platformFile.name.replaceAll(
          RegExp(r'\.las$', caseSensitive: false),
          '',
        );
        String? plotB64 = await _dataLoaderService.processLasString(wellNameWithoutExt, contents);
        _plotImageBase64 = plotB64;
        
        _activeWellFilename = platformFile.name;
        _showTripleCombo = true;
        _runCalculations();
      } catch (e) {
        debugPrint("Error parsing LAS: $e");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _runCalculations() {
    // Python backend now handles calculations during upload.
    // In a full implementation, we'd fetch the computed curves from SQLite here.
    setState(() {
      _results = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Global Main Header
          const GlobalHeader(),

          // Top Metadata Toolbar
          _buildTopToolbar(theme),

          // Main Body
          Expanded(
            child: Row(
              children: [
                // Left Sidebar (Case Manager)
                CaseManagerSidebar(
                  theme: theme,
                  onRunEngine: _runCalculations,
                  hasData: _lasData != null,
                  isCalculating: _isLoading,
                ),

                // Main Workspace
                Expanded(
                  child: Container(
                    color: theme.scaffoldBackgroundColor,
                    padding: const EdgeInsets.all(24),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              DataLoaderView(
                                theme: theme,
                                isOpen: _isDataLoaderOpen,
                                onToggle: () => setState(
                                  () => _isDataLoaderOpen = !_isDataLoaderOpen,
                                ),
                                activeWellFilename: _activeWellFilename,
                                wrangleMode: _wrangleMode,
                                onWrangleModeChanged: (v) =>
                                    setState(() => _wrangleMode = v),
                                onUpload: _pickFile,
                                hasData: _lasData != null,
                                numCurves: _lasData?.curveMnemonics.length ?? 0,
                                numRows:
                                    _lasData
                                        ?.curves[_lasData!.curveMnemonics.first]
                                        ?.length ??
                                    0,
                              ),
                              Expanded(
                                child: _showTripleCombo
                                    ? TripleComboPlot(
                                        database: widget.database,
                                        wellName: _activeWellFilename
                                            .replaceAll('.las', '')
                                            .replaceAll('.LAS', ''),
                                        base64Image: _plotImageBase64,
                                      )
                                    : _wrangleMode
                                    ? WrangleView(
                                        theme: theme,
                                        hasData: _lasData != null,
                                      )
                                    : AnalysisView(
                                        theme: theme,
                                        hasData: _lasData != null,
                                        results: _results,
                                        lasData: _lasData,
                                      ),
                              ),
                            ],
                          ),
                  ),
                ),

                // Right Parameters Panel
                if (_rightPanelOpen) _buildRightPanel(theme),
              ],
            ),
          ),

          // Global Footer
          const GlobalFooter(),
        ],
      ),
    );
  }

  Widget _buildTopToolbar(ThemeData theme) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'WELL: ',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _lasData?.wellInformation['WELL'] ?? _activeWellFilename,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Container(width: 1, height: 12, color: theme.dividerColor),
              const SizedBox(width: 16),
              Text(
                'FIELD: ',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _lasData?.wellInformation['FLD'] ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.memory,
                      size: 12,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Workspace Active',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  Icons.tune,
                  size: 16,
                  color: _rightPanelOpen
                      ? theme.colorScheme.primary
                      : Colors.white54,
                ),
                onPressed: () =>
                    setState(() => _rightPanelOpen = !_rightPanelOpen),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel(ThemeData theme) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(left: BorderSide(color: theme.dividerColor)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PARAMETERS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white54,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              _buildParamField('GR Clean (API)', _grClean, (v) => _grClean = v),
              _buildParamField('GR Clay (API)', _grClay, (v) => _grClay = v),
              const Divider(height: 32),
              const Text(
                'ARCHIE SATURATION',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white54,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              _buildParamField('Rw (ohm.m)', _rw, (v) => _rw = v),
              _buildParamField('a (Tortuosity)', _aConst, (v) => _aConst = v),
              _buildParamField('m (Cementation)', _mConst, (v) => _mConst = v),
              _buildParamField('n (Saturation)', _nConst, (v) => _nConst = v),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParamField(
    String label,
    double value,
    Function(double) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 36,
            child: TextFormField(
              initialValue: value.toString(),
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                final parsed = double.tryParse(val);
                if (parsed != null) {
                  onChanged(parsed);
                  // Optionally auto-run calculations on change
                  // _runCalculations();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
