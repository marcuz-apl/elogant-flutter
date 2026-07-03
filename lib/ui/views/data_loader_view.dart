import 'package:flutter/material.dart';

class DataLoaderView extends StatelessWidget {
  final ThemeData theme;
  final bool isOpen;
  final VoidCallback onToggle;
  final String activeWellFilename;
  final bool wrangleMode;
  final ValueChanged<bool> onWrangleModeChanged;
  final VoidCallback onUpload;
  final bool hasData;
  final int numCurves;
  final int numRows;

  const DataLoaderView({
    Key? key,
    required this.theme,
    required this.isOpen,
    required this.onToggle,
    required this.activeWellFilename,
    required this.wrangleMode,
    required this.onWrangleModeChanged,
    required this.onUpload,
    required this.hasData,
    this.numCurves = 0,
    this.numRows = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Header Row
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(isOpen ? 24.0 : 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isOpen
                            ? Icons.keyboard_arrow_down
                            : Icons.chevron_right,
                        size: 20,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.upload,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Data Registry & Log Loader',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  if (hasData)
                    Row(
                      children: [
                        if (!isOpen)
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Active: $activeWellFilename',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        const Text(
                          'Data Wrangle Mode:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.dividerColor.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => onWrangleModeChanged(true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: wrangleMode
                                        ? theme.colorScheme.primary
                                        : theme.scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(7),
                                    ),
                                  ),
                                  child: Text(
                                    'ON',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: wrangleMode
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => onWrangleModeChanged(false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !wrangleMode
                                        ? theme.colorScheme.primary
                                        : theme.scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(7),
                                    ),
                                  ),
                                  child: Text(
                                    'OFF',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: !wrangleMode
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          // Expanded Content
          if (isOpen)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Database Well
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SELECT WELL LOG FROM SQLITE DB',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.white54,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            border: Border.all(color: theme.dividerColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: activeWellFilename,
                              isExpanded: true,
                              iconSize: 16,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              dropdownColor: theme.scaffoldBackgroundColor,
                              items: [
                                DropdownMenuItem(
                                  value: activeWellFilename,
                                  child: Text(activeWellFilename),
                                ),
                                if (activeWellFilename != '-- Select Well --')
                                  const DropdownMenuItem(
                                    value: '-- Select Well --',
                                    child: Text('-- Choose log file --'),
                                  ),
                              ],
                              onChanged: (v) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // Upload Box
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'UPLOAD LAS / ASCII TEXT LOG FILE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.white54,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: onUpload,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.primary.withOpacity(
                                  0.4,
                                ),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: theme.colorScheme.primary.withOpacity(
                                0.05,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload,
                                  size: 16,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Choose File (.las, .txt, .csv)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // Summary Box
                  Expanded(
                    child: Container(
                      height: 64, // roughly matches the 40px inputs + labels
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.dividerColor.withOpacity(0.1),
                        ),
                      ),
                      child: hasData
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Available Curves: $numCurves curves',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Log Depths count: $numRows intervals',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: Text(
                                'No datasets currently loaded in memory',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
