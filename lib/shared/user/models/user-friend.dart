
import 'package:albi_hry/shared/user/models/user.dart';

class UserFriend {
  final int id;
  final int userId;
  final User? user;
  final int friendId;
  final User? friend;
  final bool accepted;
  final DateTime createdAt;
  final DateTime updatedAt;

  // interní věci
  bool selected = false;

  UserFriend({
    required this.id,
    required this.userId,
    this.user,
    required this.friendId,
    this.friend,
    required this.accepted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserFriend.fromObject(Map<String, dynamic> object) {
    return UserFriend(
      id: object['id'],
      userId: object['user_id'],
      user: object['user'] != null ? User.fromObject(object['user']) : null,
      friendId: object['friend_id'],
      friend: object['friend'] != null ? User.fromObject(object['friend']) : null,
      accepted: object['accepted'] == 0 ? false : true,
      createdAt: DateTime.parse(object['created_at']),
      updatedAt: DateTime.parse(object['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user': user?.toJson(),
      'friend_id': friendId,
      'friend': friend?.toJson(),
      'accepted': accepted == false ? 0 : 1,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}