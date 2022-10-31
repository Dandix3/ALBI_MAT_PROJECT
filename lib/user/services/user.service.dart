import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../auth/services/auth.service.dart';
import '../../config/api_config.dart';

import '../../shared/local_storage.dart';
import '../models/user.dart';

class UserService with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchAndSetUser() async {
    print("fetchAndSetUser");
    final url = Uri.parse('${ApiConfig.url}/user');
    final token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = User.fromJson(jsonDecode(response.body)['user']);
    await LocalStorage.saveData('user', jsonEncode(data.toJson()));
    _user = data;
    notifyListeners();
  }

  Future<void> getUserFromLocal() async {
    final user = await LocalStorage.getData('user');
    _user = User.fromJson(jsonDecode(user!));
    notifyListeners();
  }

  void setUserData(User data) {
    _user!.name = data.name;
    _user!.surname = data.surname;
    _user!.nickname = data.surname;
    _user!.email = data.email;
    _user!.createdAt = data.createdAt;
    notifyListeners();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }

}
