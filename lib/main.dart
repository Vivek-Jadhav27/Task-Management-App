import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_management_app/utils/theme.dart';
import 'package:task_management_app/viewmodels/preferences_viewmodel.dart';

import 'helpers/databasehelper.dart';
import 'models/preferences.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PreferencesAdapter());
  await Hive.openBox<Preferences>('preferences');

  await DatabaseHelper.instance.database;

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final preferences = ref.watch(preferencesProvider);
    
    // Set up the theme based on preferences
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management App',
      theme: preferences.isDarkMode
          ? Mytheme().darkTheme  // Dark theme
          : Mytheme().lightTheme, // Light theme
      home: const HomeScreen(),
    );
  }
}
