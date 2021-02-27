import 'package:shared_preferences/shared_preferences.dart';

/// Helper shared preference
/// Call this function to set/get/clear data from Shared Preferences
class Preferences {
  static Future<void> setDataInt(String title, int value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setInt(title, value);
  }

  static Future<void> setDataString(String title, String value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(title, value);
  }

  static Future<void> setDataBool(String title, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(title, value);
  }

  static Future<int> getDataInt(String title) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(title);
  }

  static Future<String> getDataString(String title) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(title);
  }

  static Future<bool> getDataBool(String title) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(title);
  }

  static Future<void> clearData(String title) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(title);
  }
}
