import 'dart:convert';

import 'package:albi_hry/shared/user/models/user-friend.dart';
import 'package:albi_hry/shared/utils/http/data-access/api.service.dart';
import 'package:albi_hry/shared/storage/data-access/local_storage.service.dart';
import 'package:albi_hry/shared/user/models/user.dart';
import 'package:albi_hry/shared/utils/http/models/http_response.dart';

class UserFriendService {
  static const String apiEndpoint = 'user-friends';

  static Future<HttpResponse> getFriends() async {
    final response = await ApiService.autorizedGet(apiEndpoint, null);
    return response;
  }

  static Future<HttpResponse> getFriendsRequests() async {
    final response = await ApiService.autorizedGet('$apiEndpoint/requests', null);
    return response;
  }

  static Future<HttpResponse> addFriend(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/add/$id', {});
    return response;
  }

  static Future<HttpResponse> acceptFriendRequest(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/accept/$id', {});
    return response;
  }

  static Future<HttpResponse> declineFriendRequest(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/decline/$id', {});
    return response;
  }

  static Future<HttpResponse> removeFriend(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/remove/$id', {});
    return response;
  }



}