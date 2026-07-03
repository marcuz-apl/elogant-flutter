import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:las_dart/las_dart.dart';
import 'package:path/path.dart' as p;
import '../database/database.dart';
import '../database/tables.dart';

import 'package:http/http.dart' as http;

class DataLoaderService {
  final AppDatabase database;
  String? currentDataFolder;

  DataLoaderService(this.database);

  /// Scans the currentDataFolder for .LAS files.
  Future<List<File>> getLasFiles() async {
    if (currentDataFolder == null) {
      throw Exception('Data folder not selected.');
    }

    final dir = Directory(currentDataFolder!);
    if (!await dir.exists()) {
      return [];
    }

    final List<File> lasFiles = [];
    await for (final entity in dir.list(recursive: false)) {
      if (entity is File && entity.path.toLowerCase().endsWith('.las')) {
        lasFiles.add(entity);
      }
    }

    return lasFiles;
  }

  /// Parses a LAS file and saves its log data into the database.
  Future<void> processLasFile(File file) async {
    final fileName = p.basenameWithoutExtension(file.path);
    final contents = await file.readAsString();
    await processLasString(fileName, contents);
  }

  /// Parses a LAS string directly and saves its log data into the database.
  Future<String?> processLasString(String fileName, String contents) async {
    // Send to Python Backend
    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/upload'));
    request.files.add(http.MultipartFile.fromString('file', contents, filename: '$fileName.las'));

    var response = await request.send();
    if (response.statusCode == 200) {
      final resBody = await response.stream.bytesToString();
      final dataMap = jsonDecode(resBody);
      
      final List<dynamic> mnemonics = dataMap['mnemonics'];
      final Map<String, dynamic> data = dataMap['data'];

      // Delete existing data for this well if it exists
      await (database.delete(database.lasLogData)..where((tbl) => tbl.wellName.equals(fileName))).go();

      for (var mnemonic in mnemonics) {
        final curveData = data[mnemonic];
        if (curveData != null) {
          await database
              .into(database.lasLogData)
              .insert(
                LasLogDataCompanion.insert(
                  wellName: fileName,
                  mnemonic: mnemonic as String,
                  unit: const Value(''), // Unit not currently returned by backend
                  description: const Value(''),
                  dataJson: jsonEncode(curveData),
                ),
              );
        }
      }
      return dataMap['plot_image'] as String?;
    } else {
      throw Exception('Failed to process LAS on backend. Status code: ${response.statusCode}');
    }
  }
}
