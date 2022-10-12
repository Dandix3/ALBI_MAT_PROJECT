import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _key = 'my_key';
  static const String _value = 'my_value';

  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
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