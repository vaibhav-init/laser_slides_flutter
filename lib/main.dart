import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/theme.dart';
import 'package:laser_slides/views/add_button_view.dart';
import 'package:laser_slides/views/help_view.dart';
import 'package:laser_slides/views/home_view.dart';
import 'package:laser_slides/views/settings_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: LaserSlides(),
    ),
  );
}

class LaserSlides extends ConsumerWidget {
  const LaserSlides({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(darkModeProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          useMaterial3: true,
          primaryColor: Colors.red,
          appBarTheme: const AppBarTheme(elevation: 1),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.red),
              borderRadius: BorderRadius.circular(20),
            ),
            focusColor: Colors.red,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.red),
              borderRadius: BorderRadius.circular(20),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF1E1E2C),
          brightness: Brightness.dark,
          fontFamily: 'Ubuntu',
          primaryColor: Colors.red,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E1E2C),
            elevation: 1,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(20),
            ),
            focusColor: Colors.red,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(20),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.white30,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const HomeView(),
        routes: {
          '/settings': (context) => const SettingsView(),
          '/add-edit': (context) => const AddEditButtonView(),
          '/help': (context) => const HelpView(),
        });
  }
}
