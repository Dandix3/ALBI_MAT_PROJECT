

import 'package:albi_hry/data/helpers/http/data-access/api.service.dart';
import 'package:albi_hry/data/helpers/http/models/http_response.dart';

class UserFriendService {
  static const String apiEndpoint = 'user-friends';

  Future<HttpResponse> getFriends() async {
    final response = await ApiService.autorizedGet(apiEndpoint, null);
    return response;
  }

  Future<HttpResponse> getFriendsRequests() async {
    final response = await ApiService.autorizedGet('$apiEndpoint/requests', null);
    return response;
  }

  Future<HttpResponse> addFriend(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/add/$id', {});
    return response;
  }

  Future<HttpResponse> acceptFriendRequest(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/accept/$id', {});
    return response;
  }

  Future<HttpResponse> declineFriendRequest(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/decline/$id', {});
    return response;
  }

  Future<HttpResponse> removeFriend(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/remove/$id', {});
    return response;
  }



}