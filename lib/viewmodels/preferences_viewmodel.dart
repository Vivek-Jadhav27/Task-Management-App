import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/preferences.dart';
import '../repositories/preferences_repository.dart';

class PreferencesViewModel extends StateNotifier<Preferences> {
  final PreferencesRepository _preferencesRepository;

  PreferencesViewModel(this._preferencesRepository)
      : super(Preferences(isDarkMode: false, sortOrder: 'date'));

  // Call init method to open the Hive box
  Future<void> init() async {
    await _preferencesRepository.init();
    state = _preferencesRepository.getPreferences(); // Make sure state is initialized
  }

  // Toggle Dark Mode
  void toggleTheme() {
    final updated = Preferences(
      isDarkMode: !state.isDarkMode,
      sortOrder: state.sortOrder,
    );
    _preferencesRepository.savePreferences(updated);
    state = updated; // Update the state after saving
  }

  // Update Sort Order
  void updateSortOrder(String newSortOrder) {
    final updated = Preferences(
      isDarkMode: state.isDarkMode,
      sortOrder: newSortOrder,
    );
    _preferencesRepository.savePreferences(updated);
    state = updated; 
  }
}

// Riverpod provider for PreferencesViewModel
final preferencesProvider =
    StateNotifierProvider<PreferencesViewModel, Preferences>((ref) {
  final preferencesRepository = PreferencesRepository();
  return PreferencesViewModel(preferencesRepository);
});
