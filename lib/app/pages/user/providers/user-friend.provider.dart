import 'package:albi_hry/app/widgets/snackbars/success_snackbar.dart';
import 'package:albi_hry/common/user/models/user-friend.dart';
import 'package:albi_hry/data/helpers/http/models/http_response.dart';
import 'package:albi_hry/data/repositories/user/data-access/user-friend.service.dart';
import 'package:flutter/material.dart';


class UserFriendProvider with ChangeNotifier {

  UserFriendService _userFriendService = UserFriendService();

  List<UserFriend> _friends = [];
  List<UserFriend> _friendsRequests = [];
  List<UserFriend> _pendingFriendRequests = [];

  List<UserFriend> get friends => _friends;
  List<UserFriend> get friendsRequests => _friendsRequests;
  List<UserFriend> get friendsPending => _pendingFriendRequests;

  bool _friendStatus = false;

  get friendStatus => _friendStatus;

  UserFriendProvider() {
    fetchAndSetFriends();
  }

  Future<void> fetchAndSetFriends() async {
    return _userFriendService.getFriends().then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
      } else { }
    });
  }

  Future<void> fetchAndSetFriendsRequests() async {
    await _userFriendService.getFriendsRequests().then((value) {
      if (value.statusCode == 200) {
        _setFriends(value);
        notifyListeners();
      } else {
        //todo: handle error
      }
    });
  }

  Future<void> addFriend(int id) async {
    await _userFriendService.addFriend(id).then((value) {
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
    await _userFriendService.acceptFriendRequest(id).then((value) {
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
    await _userFriendService.declineFriendRequest(id).then((value) {
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
    await _userFriendService.removeFriend(id).then((value) {
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

  void setFriendStatus() {
    _friendStatus = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      _friendStatus = false;
      notifyListeners();
    });
  }

  void _setFriends(HttpResponse value) {
    _friends = value.data['friends'] != [] ? (value.data['friends'] as List).map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];
    _friendsRequests = value.data['friendRequests'] != [] ? (value.data['friendRequests'] as List).map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];
    _pendingFriendRequests = value.data['pendingFriendRequests'] != [] ? (value.data['pendingFriendRequests'] as List).map<UserFriend>((x) => UserFriend.fromObject(x)).toList() : [];
  }
}
