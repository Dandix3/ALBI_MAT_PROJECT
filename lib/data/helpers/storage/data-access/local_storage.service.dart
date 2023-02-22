import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _key = 'my_key';
  static const String _value = 'my_value';

  static Future<void> saveData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  static Future getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value != null) {
      return jsonDecode(value);
    } else {
      return null;
    }
  }

  static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<void> saveDataList(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_key, list);
  }

  static Future<List<String>?> getDataList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key);
  }
}