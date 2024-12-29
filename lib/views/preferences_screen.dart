import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/preferences_viewmodel.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the preferences provider
    final preferences = ref.watch(preferencesProvider);
    final preferencesNotifier = ref.read(preferencesProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Preferences')),
      body: FutureBuilder<void>(
        future: preferencesNotifier.init(), // Initialize preferences repository
        builder: (context, snapshot) {
          // Show loading indicator while initializing
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Toggle Dark Mode
                SwitchListTile(
                  title: Text('Dark Mode' ,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),),
                  value: preferences.isDarkMode,
                  onChanged: (value) {
                    preferencesNotifier.toggleTheme();
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:  const EdgeInsets.only(right: 10, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sort by :',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 10), 
                      Expanded( 
                        child: DropdownButton<String>(
                          value: preferences.sortOrder,
                          onChanged: (value) {
                            if (value != null) {
                              preferencesNotifier.updateSortOrder(value);
                            }
                          },
                          isExpanded: true, 
                          items:  [
                            DropdownMenuItem(
                              value: 'date',
                              child: Text('Date',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),),
                            ),
                            DropdownMenuItem(
                              value: 'priority',
                              child: Text('Priority',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
