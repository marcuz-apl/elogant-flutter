import 'package:drift/drift.dart';

DatabaseConnection connect(String dbDirectoryPath) {
  throw UnsupportedError(
    'No suitable database implementation was found on this platform.',
  );
}
