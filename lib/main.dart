import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/app/app.dart';

void main() {
  // hl3 force to potrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitUp])
  //     .then((fn) {
  //   runApp(const ProviderScope(child: MyApp(),),);
  // });
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
  seedColor: const Color.fromARGB(255, 15, 23, 42),
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
        textTheme: ThemeData().textTheme.copyWith(
              displaySmall: GoogleFonts.comicNeue(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: lightScheme.primary,
              ),
              bodySmall: TextStyle(
                color: lightScheme.onBackground,
                fontSize: 12,
              ),
              bodyMedium: GoogleFonts.poppins(
                color: lightScheme.onBackground,
                fontSize: 14,
              ),
              bodyLarge: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: lightScheme.onInverseSurface,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkScheme.onPrimaryContainer,
            foregroundColor: darkScheme.onPrimary,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: darkScheme.onPrimaryContainer,
          ),
        ),
        iconTheme: const IconThemeData().copyWith(
          color: darkScheme.onSurfaceVariant,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              displaySmall: GoogleFonts.comicNeue(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: darkScheme.primary,
              ),
              bodySmall: TextStyle(
                color: darkScheme.onBackground,
                fontSize: 12,
              ),
              bodyMedium: GoogleFonts.poppins(
                color: darkScheme.onBackground,
                fontSize: 14,
              ),
              bodyLarge: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
      ),
      home: const App(),
    );
  }
}
