import 'package:albi_hry/shared/user/data-access/user.service.dart';
import 'package:crypt/crypt.dart';

import 'package:albi_hry/shared/utils/http/models/http_response.dart';
import '../../utils/http/data-access/api.service.dart';
import '../../storage/data-access/local_storage.service.dart';

class AuthService {
  static String apiEndpoint = 'auth';

  UserService _userService = UserService();


  static Future<void> clearToken() async {
    await LocalStorage.removeData('token');
  }

  static Future<String?> getToken() async {
    return await LocalStorage.getData('token');
  }

  static Future<HttpResponse> login(String email, String password) async {
    var hash = Crypt.sha256(password, salt: '\$2\$10\$1qAz2wSx3eDc4rFv5tGb\$');
    final response = await ApiService.post('$apiEndpoint/login', {
      'email': email,
      'password': hash.toString(),
    });
    return response;
  }

  static Future<HttpResponse> register(String email, String password, String name, String surname, String nickname) async {
    final hash = Crypt.sha256(password, salt: '\$2\$10\$1qAz2wSx3eDc4rFv5tGb\$');
    final response = await ApiService.post('$apiEndpoint/register', {
      'email': email,
      'password': hash.toString(),
      'first_name': name,
      'last_name': surname,
      'nickname': nickname,
    });
    return response;
  }

  Future<HttpResponse> logout() async {
    final response = await ApiService.autorizedPost('$apiEndpoint/logout', {});
    await _userService.clearUser();
    await clearToken();
    return response;
  }
}
