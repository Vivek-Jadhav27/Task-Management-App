import 'package:hive/hive.dart';
import '../models/preferences.dart';

class PreferencesRepository {
  late Box<Preferences> _preferencesBox;

  // Async method to initialize the repository and open the Hive box
  Future<void> init() async {
    _preferencesBox = await Hive.openBox<Preferences>('preferences');
  }

  Preferences getPreferences() {
    // Ensure that the box is initialized before accessing it
    if (_preferencesBox.isOpen) {
      return _preferencesBox.get('preferences') ?? Preferences(isDarkMode: false, sortOrder: 'date');
    } else {
      throw Exception('Preferences box is not initialized');
    }
  }

  void savePreferences(Preferences preferences) {
    if (_preferencesBox.isOpen) {
      _preferencesBox.put('preferences', preferences);
    } else {
      throw Exception('Preferences box is not initialized');
    }
  }
}
