import 'package:albi_hry/common/user/models/user.dart';
import 'package:albi_hry/data/helpers/http/data-access/api.service.dart';
import 'package:albi_hry/data/helpers/http/models/http_response.dart';
import 'package:albi_hry/data/helpers/storage/data-access/local_storage.service.dart';


class UserService {
  static const String apiEndpoint = 'users';

  UserService();

  Future<HttpResponse> findUser(String nickname) async {
    final response = await ApiService.get('$apiEndpoint/nickname/$nickname', {});
    return response;
  }

  Future<User> getUserByToken() async {
    final response = await ApiService.autorizedGet('$apiEndpoint/user', null);
    final user = User.fromJson(response.data);
    await saveUser(user);
    return user;
  }

  Future<User?> getUserFromLocal() async {
    final user = await LocalStorage.getData('user');
    if (user == null) {
      return null;
    }
    return User.fromJson(user);
  }

  Future<void> saveUser(User user) async {
    await LocalStorage.saveData('user', user);
  }

  Future<void> clearUser() async {
    await LocalStorage.removeData('user');
  }

  Future<void> updateUser(User user) async {
    final response = await ApiService.autorizedPut('$apiEndpoint/user', user.toJson());
    await saveUser(response.data);
  }

}