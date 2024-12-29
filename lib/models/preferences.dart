import 'package:hive/hive.dart';

part 'preferences.g.dart'; 

@HiveType(typeId: 0)
class Preferences {
  @HiveField(0)
  bool isDarkMode;

  @HiveField(1)
  String sortOrder;

  Preferences({this.isDarkMode = false, this.sortOrder = 'date'});
}
