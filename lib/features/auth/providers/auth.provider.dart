import 'dart:io';

import 'package:albi_hry/shared/auth/data-access/auth.service.dart';
import 'package:albi_hry/shared/storage/data-access/local_storage.service.dart';
import 'package:flutter/material.dart';

import 'package:albi_hry/shared/utils/http/models/http_response.dart';

import '../../library/providers/library.provider.dart';
import '../../user/providers/user-friend.provider.dart';
import '../../user/providers/user.provider.dart';

class AuthProvider with ChangeNotifier {

  final AuthService _authService = AuthService();

  final UserProvider? _userProvider;
  final LibraryProvider? _libraryProvider;

  AuthProvider(this._userProvider, this._libraryProvider) {
    // todo: při pull refreshi se to aktivuje a buggne
    isLoggedIn();
  }

  bool isAuthenticated = false;


  //bool get isAuthenticated => isAuthenticated;

  Future<HttpResponse> login(String email, String password) async {
    try {
      final response = await AuthService.login(email, password);
      print(response);
      if (response.statusCode == 200) {
        await LocalStorage.saveData('token', response.data);
        isAuthenticated = true;
        _userProvider!.fetchAndSetUser();
        _libraryProvider!.fetchAndSetLibrary();
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } on SocketException catch (e) {
      throw Exception('No internet connection');
    }
  }

  Future<HttpResponse> register(String email, String password, String name, String surname, String nickname) async {
    try {
      final response = await AuthService.register(email, password, name, surname, nickname);
      if (response.statusCode == 201) {
        await LocalStorage.saveData('token', response.data);
        _userProvider!.fetchAndSetUser();
        isAuthenticated = true;
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } on SocketException catch (e) {
      throw Exception('No internet connection');
    }
  }

  Future<String?> logout() async {
    try {
      final response = await _authService.logout();
      isAuthenticated = false;
      _libraryProvider!.clearLibrary();
      notifyListeners();
      if (response.statusCode == 200) {
        return response.message;
      } else {
        return response.message!;
      }
    } on SocketException catch (e) {
      return 'No internet connection';
      throw Exception('No internet connection');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await AuthService.getToken();
    if (token != null) {
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
