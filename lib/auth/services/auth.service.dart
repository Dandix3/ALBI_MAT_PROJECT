import 'dart:convert';
import 'package:albi_hry/user/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypt/crypt.dart';
import '../../config/api_config.dart';
import 'package:albi_hry/shared/http_response.dart';
import 'package:albi_hry/shared/local_storage.dart';

class AuthService with ChangeNotifier {
  bool isAuthenticated;

  AuthService({this.isAuthenticated = false});

  Future<bool> login(String email, String password, UserService userService) async {
    var hash = Crypt.sha256(password, salt: '\$2\$10\$1qAz2wSx3eDc4rFv5tGb\$');
    final response = await http.post(
      Uri.parse('${ApiConfig.url}/login'),
      body: {
        'email': email,
        'password': hash.toString(),
      },
    );
    final login = HttpResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      LocalStorage.saveData('token', login.token!);
      userService.fetchAndSetUser();
      isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      print(login.message);
      throw Exception('Failed to login');
    }
  }

  Future<HttpResponse> register(String email, String password, String name, String surname, String nickname, UserService userService) async {
    final hash = Crypt.sha256(password, salt: '\$2\$10\$1qAz2wSx3eDc4rFv5tGb\$');
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.url}/register'),
        body: {
          'email': email,
          'password': hash.toString(),
          'first_name': name,
          'last_name': surname,
          'nickname': nickname,
        },
      );
      final data = HttpResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == 201) {
        LocalStorage.saveData('token', data.token!);
        userService.fetchAndSetUser();
        isAuthenticated = true;
        return data;
      } else if (response.statusCode == 403) {
        return data;
      } else {
        print(data.message);
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('No internet connection');
    }
  }

  Future<bool> logout() async {
    LocalStorage.removeData('token');
    isAuthenticated = false;
    notifyListeners();
    return true;
  }

  static Future getToken() async {
    final token = await LocalStorage.getData('token');
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  Future<bool> isLoggedIn(UserService userService) async {
    final token = await LocalStorage.getData('token');
    if (token != null) {
      userService.getUserFromLocal();
      isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }
}
