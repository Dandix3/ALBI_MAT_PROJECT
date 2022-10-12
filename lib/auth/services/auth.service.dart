import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';
import '../models/login.dart';

class AuthService with ChangeNotifier {
  bool isAuthenticated;

  AuthService({this.isAuthenticated = false});

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.url}/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final login = Login.fromJson(jsonDecode(response.body));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', login.token);
      return true;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.url}/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    isAuthenticated = false;
    notifyListeners();
    return true;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
