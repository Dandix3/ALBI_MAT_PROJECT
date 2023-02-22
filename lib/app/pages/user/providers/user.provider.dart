import 'package:albi_hry/app/widgets/snackbars/error_snackbar.dart';
import 'package:albi_hry/common/user/models/user.dart';
import 'package:albi_hry/data/repositories/auth/data-access/auth.service.dart';
import 'package:albi_hry/data/repositories/user/data-access/user.service.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {

  final UserService _userService = UserService();

  User? _user;

  User? get user => _user;

  UserProvider() {
    AuthService.getToken().then((token) {
      if (token != null) {
        _userService.getUserFromLocal().then((user) {
          if (user == null) {
            fetchAndSetUser();
          } else {
            _user = user;
            notifyListeners();
          }
        });
      }
    });
  }

  Future<User?> findUser(String nickname, BuildContext context) async {
     return await _userService.findUser(nickname).then((value) {
       if (value.statusCode == 200) {
         return User.fromJson(value.data);
       } else if (value.statusCode == 404) {
          throwError(context: context, title: 'Uživatel nenalezen', message: 'Uživatel s touto přezdívkou neexistuje');
          return null;
         //todo: handle error
       }
     });
  }

  Future<void> fetchAndSetUser() async {
    final user = await _userService.getUserByToken();
    _user = user;
    notifyListeners();
  }

  Future<void> getUserFromLocal() async {
    final user = await _userService.getUserFromLocal();
    _user = user;
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

  void clearUser() {
    _user = null;
    notifyListeners();
  }

}
