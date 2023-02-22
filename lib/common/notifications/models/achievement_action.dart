


import 'package:albi_hry/common/game/models/game_achievement.dart';
import 'package:albi_hry/common/user/models/user.dart';

class AchievementAction {

  final int id;
  final User friend;
  final GameAchievement achievement;
  final String prevState;
  final String newState;
  final DateTime createdAt;
  final DateTime updatedAt;

  AchievementAction({
    required this.id,
    required this.friend,
    required this.achievement,
    required this.prevState,
    required this.newState,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AchievementAction.fromObject(Map<String, dynamic> object) {
    return AchievementAction(
      id: object['id'],
      friend: User.fromObject(object['friend']),
      achievement: GameAchievement.fromObject(object['achievement']),
      prevState: object['prev_state'],
      newState: object['new_state'],
      createdAt: DateTime.parse(object['created_at']),
      updatedAt: DateTime.parse(object['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'friend': friend.toJson(),
      'achievement': achievement.toJson(),
      'prev_state': prevState,
      'new_state': newState,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}