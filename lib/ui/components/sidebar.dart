import 'package:flutter/material.dart';

class CaseManagerSidebar extends StatefulWidget {
  final ThemeData theme;
  final VoidCallback onRunEngine;
  final bool hasData;
  final bool isCalculating;

  const CaseManagerSidebar({
    Key? key,
    required this.theme,
    required this.onRunEngine,
    required this.hasData,
    this.isCalculating = false,
  }) : super(key: key);

  @override
  State<CaseManagerSidebar> createState() => _CaseManagerSidebarState();
}

class _CaseManagerSidebarState extends State<CaseManagerSidebar> {
  String _folder = 'Interpretation Cases';
  String _caseName = 'Base Case';
  String _resolution = '0.50';

  // Mocked Scenarios
  final Map<String, List<Map<String, dynamic>>> _mockScenarios = {
    'Interpretation Cases': [
      {'id': 1, 'name': 'Base Case', 'well_name': 'WA1'},
      {'id': 2, 'name': 'High Porosity Sens', 'well_name': 'WA1'},
    ],
    'ML Training Sets': [
      {'id': 3, 'name': 'XGBoost Baseline', 'well_name': 'WA2'},
    ],
  };

  int _activeScenarioId = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: widget.theme.cardColor,
        border: Border(
          right: BorderSide(color: widget.theme.dividerColor.withOpacity(0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Interpretation Controls
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.theme.dividerColor.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'INTERPRETATION CONTROLS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white54,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'RESOLUTION',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: widget.theme.scaffoldBackgroundColor,
                              border: Border.all(
                                color: widget.theme.dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _resolution,
                                isExpanded: true,
                                iconSize: 14,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                                dropdownColor:
                                    widget.theme.scaffoldBackgroundColor,
                                items: const [
                                  DropdownMenuItem(
                                    value: '0.50',
                                    child: Text('Normal - 0.50'),
                                  ),
                                  DropdownMenuItem(
                                    value: '0.25',
                                    child: Text('High - 0.25'),
                                  ),
                                ],
                                onChanged: (v) =>
                                    setState(() => _resolution = v!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 28,
                  child: ElevatedButton.icon(
                    onPressed: widget.hasData && !widget.isCalculating
                        ? widget.onRunEngine
                        : null,
                    icon: widget.isCalculating
                        ? const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.refresh, size: 14),
                    label: const Text('Run Engine'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: widget.theme.colorScheme.primary
                          .withOpacity(0.5),
                      textStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Case Manager Mock Form
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.theme.dividerColor.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CASE MANAGER',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white54,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 32,
                  child: TextField(
                    controller: TextEditingController(text: _folder),
                    onChanged: (v) => _folder = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: InputDecoration(
                      hintText: 'Folder',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      filled: true,
                      fillColor: widget.theme.scaffoldBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: widget.theme.dividerColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: widget.theme.dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 32,
                  child: TextField(
                    controller: TextEditingController(text: _caseName),
                    onChanged: (v) => _caseName = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: InputDecoration(
                      hintText: 'Case Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      filled: true,
                      fillColor: widget.theme.scaffoldBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: widget.theme.dividerColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: widget.theme.dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: widget.hasData
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Mock SQLite: Case Saved Successfully',
                                ),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.save, size: 14),
                    label: const Text('Save Case'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget
                          .theme
                          .colorScheme
                          .primary, // using primary as base for gradient mock
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Historical Cases List
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SAVED CASES',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white54,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: _mockScenarios.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.folder,
                                    size: 12,
                                    color: Colors.white54,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    entry.key.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: widget.theme.dividerColor
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: entry.value.map((sc) {
                                    bool isActive =
                                        _activeScenarioId == sc['id'];
                                    return InkWell(
                                      onTap: () => setState(
                                        () => _activeScenarioId = sc['id'],
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? widget
                                                    .theme
                                                    .scaffoldBackgroundColor
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.description,
                                              size: 12,
                                              color: Colors.white70,
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                '${sc['name']}',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: isActive
                                                      ? FontWeight.bold
                                                      : FontWeight.w500,
                                                  color: isActive
                                                      ? widget
                                                            .theme
                                                            .colorScheme
                                                            .primary
                                                      : Colors.white70,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              '(${sc['well_name']})',
                                              style: const TextStyle(
                                                fontSize: 9,
                                                color: Colors.white38,
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
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
