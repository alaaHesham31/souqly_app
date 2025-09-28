import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Write a string
  static Future<bool> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (e) {
      debugPrint('SecureStorage write error: $e');
      return false;
    }
  }

  // Read a string (returns null if missing or error)
  static Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      debugPrint('SecureStorage read error: $e');
      return null;
    }
  }

  // Delete a key
  static Future<bool> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e) {
      debugPrint('SecureStorage delete error: $e');
      return false;
    }
  }

  // Helpers for common primitive conversions (optional)
  static Future<bool> writeBool(String key, bool value) =>
      write(key, value.toString());

  static Future<bool?> readBool(String key) async {
    final s = await read(key);
    if (s == null) return null;
    return s.toLowerCase() == 'true';
  }

  static Future<void> deleteAll() => _storage.deleteAll();
  static Future<Map<String, String>> readAll() => _storage.readAll();
}
