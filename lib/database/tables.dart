import 'package:drift/drift.dart';

class LasLogData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wellName => text()();
  TextColumn get mnemonic => text()();
  TextColumn get unit => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get dataJson => text()(); // Store the array of data as JSON
}

class PetrophysicalParameters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wellName => text()();
  RealColumn get a =>
      real().withDefault(const Constant(1.0))(); // Tortuosity factor
  RealColumn get m =>
      real().withDefault(const Constant(2.0))(); // Cementation exponent
  RealColumn get n =>
      real().withDefault(const Constant(2.0))(); // Saturation exponent
}

class AnalysisResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wellName => text()();
  TextColumn get resultType => text()(); // e.g., 'Sw', 'Vsh'
  TextColumn get dataJson => text()(); // Array of result values as JSON
}
