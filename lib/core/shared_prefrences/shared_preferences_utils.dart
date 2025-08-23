import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesUtils {
  static late SharedPreferences prefs;

  static Future<void> sharedInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  // save data

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await prefs.setString(key, value);
    if (value is bool) return await prefs.setBool(key, value);
    if (value is double) return await prefs.setDouble(key, value);
    if (value is int) return await prefs.setInt(key, value);
    return false;
  }

// get data
  static String? getString(String key) => prefs.getString(key);
  static bool? getBool(String key) => prefs.getBool(key);
  static int? getInt(String key) => prefs.getInt(key);
  static double? getDouble(String key) => prefs.getDouble(key);

  // remove data
  static Future<bool> removeData({required String key}) async {
    return await prefs.remove(key);
  }
}
