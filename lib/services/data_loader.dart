import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:drift/drift.dart';
import 'package:las_dart/las_dart.dart';
import 'package:path/path.dart' as p;

import '../core/data/las_parser.dart';

import '../database/database.dart';
import '../database/tables.dart';

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
  Future<void> processLasString(String fileName, String contents) async {
    final lasData = await LasParser.parseString(contents);

    // `curves` is a List<WellProps>. `rawData` is a Map<String, List<double>> from LasParser.
    for (var mnemonic in lasData.curveMnemonics) {
      final curveData = lasData.curves[mnemonic];
      final unit = lasData.wellInformation[mnemonic] ?? '';

      if (curveData != null) {
        await database
            .into(database.lasLogData)
            .insert(
              LasLogDataCompanion.insert(
                wellName: fileName,
                mnemonic: mnemonic,
                unit: Value(unit),
                description: Value(''),
                dataJson: jsonEncode(curveData),
              ),
            );
      }
    }
  }
}
