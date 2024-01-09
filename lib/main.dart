import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          useMaterial3: true,
        ),
        home: const HomeView(),
        routes: {
          '/settings': (context) => const SettingsView(),
        });
  }
}
