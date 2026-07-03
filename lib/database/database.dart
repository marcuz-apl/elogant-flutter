import 'package:drift/drift.dart';

import 'tables.dart';

import 'connection_interface.dart'
    if (dart.library.io) 'connection_native.dart'
    if (dart.library.html) 'connection_web.dart';

part 'database.g.dart';

@DriftDatabase(tables: [LasLogData, PetrophysicalParameters, AnalysisResults])
class AppDatabase extends _$AppDatabase {
  AppDatabase(String dbDirectoryPath) : super(connect(dbDirectoryPath));

  @override
  int get schemaVersion => 1;
}
