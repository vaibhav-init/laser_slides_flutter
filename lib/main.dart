import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/theme.dart';
import 'package:laser_slides/views/add_button_view.dart';
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
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          useMaterial3: true,
          primaryColor: Colors.red,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const HomeView(),
        routes: {
          '/settings': (context) => const SettingsView(),
          '/add-edit': (context) => const AddEditButtonView(),
        });
  }
}
