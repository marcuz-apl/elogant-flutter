import 'dart:convert';

class LasData {
  final Map<String, String> wellInformation;
  final List<String> curveMnemonics;
  final Map<String, List<double>> curves;

  LasData({
    required this.wellInformation,
    required this.curveMnemonics,
    required this.curves,
  });

  /// Get a specific curve by its mnemonic.
  /// Converts standard null values (like -999.25 or -9999) to double.nan for easier math.
  List<double> getCurve(String mnemonic, {double nullValue = -999.25}) {
    List<double>? rawCurve = curves[mnemonic];

    // Intelligent fallback for Depth curve (matches python pandas logic)
    if (mnemonic == 'DEPT' && rawCurve == null) {
      if (curves.containsKey('DEPTH'))
        rawCurve = curves['DEPTH'];
      else if (curves.containsKey('M__DEPTH'))
        rawCurve = curves['M__DEPTH'];
      else if (curves.containsKey('MD'))
        rawCurve = curves['MD'];
      else if (curveMnemonics.isNotEmpty)
        rawCurve = curves[curveMnemonics[0]]; // fallback to first column
    }

    if (rawCurve == null) return [];

    return rawCurve
        .map((e) => (e == nullValue || e == -9999.0) ? double.nan : e)
        .toList();
  }
}

class LasParser {
  static Future<LasData> parseString(String contents) async {
    final lines = const LineSplitter().convert(contents);

    Map<String, String> wellInfo = {};
    List<String> curveMnemonics = [];
    Map<String, List<double>> curves = {};

    if (!contents.contains('~')) {
      // Fallback for plain text space-separated tabular data (like WA1.txt)
      for (int i = 0; i < lines.length; i++) {
        String line = lines[i].trim();
        if (line.isEmpty) continue;

        if (curveMnemonics.isEmpty) {
          // First non-empty line is headers
          List<String> headers = line
              .split(RegExp(r'\s+'))
              .where((s) => s.isNotEmpty)
              .toList();
          for (String h in headers) {
            if (h == 'M__DEPTH') h = 'DEPT';
            curveMnemonics.add(h);
            curves[h] = [];
          }
        } else {
          // Data rows
          List<String> values = line
              .split(RegExp(r'\s+'))
              .where((s) => s.isNotEmpty)
              .toList();
          int minLen = values.length < curveMnemonics.length
              ? values.length
              : curveMnemonics.length;
          for (int j = 0; j < minLen; j++) {
            double val = double.tryParse(values[j]) ?? double.nan;
            if (val == -999.0 ||
                val == -999.00000 ||
                val == -999.25 ||
                val == -9999.0) {
              val = double.nan;
            }
            curves[curveMnemonics[j]]!.add(val);
          }
        }
      }
      return LasData(
        wellInformation: wellInfo,
        curveMnemonics: curveMnemonics,
        curves: curves,
      );
    }

    String currentSection = '';

    for (String line in lines) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('#')) continue;

      if (line.startsWith('~')) {
        currentSection = line.substring(1, 2).toUpperCase();
        continue;
      }

      if (currentSection == 'W') {
        // ~Well Information Section
        if (line.contains(':')) {
          var parts = line.split(':');
          var subParts = parts[0].split('.');
          if (subParts.isNotEmpty) {
            String key = subParts[0].trim();
            String value = subParts.length > 1
                ? subParts.sublist(1).join('.').trim()
                : '';
            wellInfo[key] = value;
          }
        }
      } else if (currentSection == 'C') {
        // ~Curve Information Section
        if (line.contains(':')) {
          var parts = line.split(':');
          var subParts = parts[0].split('.');
          if (subParts.isNotEmpty) {
            String mnemonic = subParts[0].trim();
            curveMnemonics.add(mnemonic);
            curves[mnemonic] = [];
          }
        }
      } else if (currentSection == 'A') {
        // ~ASCII Data Section
        List<String> values = line
            .split(RegExp(r'\s+'))
            .where((s) => s.isNotEmpty)
            .toList();
        int minLen = values.length < curveMnemonics.length
            ? values.length
            : curveMnemonics.length;
        for (int i = 0; i < minLen; i++) {
          double val = double.tryParse(values[i]) ?? -999.25;
          curves[curveMnemonics[i]]!.add(val);
        }
      }
    }

    return LasData(
      wellInformation: wellInfo,
      curveMnemonics: curveMnemonics,
      curves: curves,
    );
  }
}
