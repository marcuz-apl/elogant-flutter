import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'database/database.dart';
import 'ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String dbPath = 'elogant_web';
  if (!kIsWeb) {
    final dir = await getApplicationSupportDirectory();
    dbPath = dir.path;
  }
  final database = AppDatabase(dbPath);
  runApp(ElogantApp(database: database));
}

class ElogantApp extends StatelessWidget {
  final AppDatabase database;

  const ElogantApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elogant Petrophysics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFa78bfa),
        scaffoldBackgroundColor: const Color(
          0xFF0f172a,
        ), // bg-background (slate-900)
        cardColor: const Color(0xFF1e293b), // bg-sidebar (slate-800)
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFFa78bfa), // purple active
          secondary: const Color(0xFF10b981), // emerald
          surface: const Color(0xFF1e293b),
          error: const Color(0xFFf43f5e), // rose
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1e293b),
          elevation: 0,
        ),
        dividerColor: const Color(0xFF334155), // card-border
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Inter', // Sleek font
        ),
      ),
      home: HomeScreen(database: database),
    );
  }
}
