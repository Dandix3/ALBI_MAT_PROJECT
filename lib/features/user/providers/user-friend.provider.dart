import 'package:albi_hry/features/user/providers/user.provider.dart';
import 'package:albi_hry/shared/user/data-access/user-friend.service.dart';
import 'package:albi_hry/shared/user/models/user.dart';
import 'package:albi_hry/shared/utils/snackbars/success_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:albi_hry/shared/utils/http/models/http_response.dart';

import '../../../shared/user/models/user-friend.dart';


class UserFriendProvider with ChangeNotifier {

  List<UserFriend> _friends = [];
  List<UserFriend> _friendsRequests = [];
  List<UserFriend> _pendingFriendRequests = [];

  List<UserFriend> get friends => _friends;
  List<UserFriend> get friendsRequests => _friendsRequests;
  List<UserFriend> get friendsPending => _pendingFriendRequests;

  UserFriendProvider() {
    fetchAndSetFriends();
  }

  Future<void> fetchAndSetFriends() async {
    await UserFriendService.getFriends().then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
      } else {
        //todo: handle error
      }
    });
  }

  Future<void> fetchAndSetFriendsRequests() async {
    await UserFriendService.getFriendsRequests().then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
      } else {
        //todo: handle error
      }
    });
  }

  Future<void> addFriend(int id) async {
    await UserFriendService.addFriend(id).then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
      } else {
        //todo: show error
      }
    });
  }
// cock
  Future<void> acceptFriendRequest(int id, BuildContext context) async {
    await UserFriendService.acceptFriendRequest(id).then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
        throwSuccess(context: context, title: 'Žádost o přátelství přijata');
      } else {
        // todo: show error
      }
    });
  }

  Future<void> declineFriendRequest(int id, BuildContext context) async {
    await UserFriendService.declineFriendRequest(id).then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
        throwSuccess(context: context, title: 'Žádost o přátelství odmítnuta');
      } else {
        // todo: show error
      }
    });
  }

  Future<bool> removeFriend(int id, BuildContext context) async {
    await UserFriendService.removeFriend(id).then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
        throwSuccess(context: context, title: 'Přítel odebrán');
      } else {
        // todo: show error
      }
    });
    return true;
  }

  Future<void> fetchAndSetFriendsAndRequests() async {
    await fetchAndSetFriends();
    await fetchAndSetFriendsRequests();
  }

  void clearFriends() {
    _friends = [];
    notifyListeners();
  }

  void clearFriendsRequests() {
    _friendsRequests = [];
    notifyListeners();
  }

  void _setFriends(HttpResponse value) {
   // _friends = value.data != [] ? value.data.map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];

    _friends = value.data['friends'] != [] ? (value.data['friends'] as List).map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];
    _friendsRequests = value.data['friendRequests'] != [] ? (value.data['friendRequests'] as List).map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];
    _pendingFriendRequests = value.data['pendingFriendRequests'] != [] ? (value.data['pendingFriendRequests'] as List).map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];
  }
}
