import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kharcha/app/app.dart';
import 'package:kharcha/hive_model.dart';

void main() async {
  // hl3 force to potrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitUp])
  //     .then((fn) {
  //   runApp(const ProviderScope(child: MyApp(),),);
  // });
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  // hl3 responsive mode
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final lightScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 167, 139, 250),
);

final darkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 167, 139, 250),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: lightScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightScheme.primary,
            foregroundColor: lightScheme.onPrimary,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: lightScheme.primary,
          ),
        ),
        iconTheme: const IconThemeData().copyWith(
          color: lightScheme.onSurfaceVariant,
        ),
        textTheme: GoogleFonts.kalamTextTheme().apply(
          bodyColor: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          helperStyle: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          hintStyle: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkScheme.secondary,
            foregroundColor: darkScheme.scrim,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: darkScheme.primary,
          ),
        ),
        iconTheme: const IconThemeData().copyWith(
          color: darkScheme.primary,
        ),
        textTheme: GoogleFonts.comicNeueTextTheme().apply(
          bodyColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          helperStyle: TextStyle(
            color: Colors.white60,
            fontSize: 14,
          ),
          hintStyle: TextStyle(
            color: Colors.white60,
            fontSize: 14,
          ),
        ),
      ),
      home: const App(),
    );
  }
}
