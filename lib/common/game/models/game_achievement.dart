import 'package:albi_hry/common/game/models/user_achievement.dart';

class GameAchievement {
  final int id;
  final int gameId;
  final String gameName;
  final String title;
  final String? description;
  final int minPoints;
  final int maxPoints;
  int userPoints;
  UserAchievement? userAchievement;
  final int? nextAchievement;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GameAchievement({
    required this.id,
    required this.gameId,
    required this.gameName,
    required this.title,
    this.description,
    required this.minPoints,
    required this.maxPoints,
    required this.userPoints,
    required this.userAchievement,
    this.nextAchievement,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GameAchievement.fromObject(dynamic data) {
    return GameAchievement(
      id: data['id'],
      gameId: data['game_id'],
      gameName: data['game_name'],
      title: data['title'],
      description: data['description'],
      minPoints: data['min_points'],
      maxPoints: data['max_points'],
      userPoints: data['user_points'],
      userAchievement: data['user_achievement'] != null ? UserAchievement.fromObject(data['user_achievement']) : null,
      nextAchievement: data['next_achievement'],
      status: data['status_id'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  factory GameAchievement.fromJson(Map<String, dynamic> json) => GameAchievement(
    id: json["id"],
    gameId: json["game_id"],
    gameName: json["game_name"],
    title: json["title"],
    description: json["description"],
    minPoints: json["min_points"],
    maxPoints: json["max_points"],
    userPoints: json["user_points"],
    userAchievement: UserAchievement.fromJson(json["user_achievement"]),
    nextAchievement: json["next_achievement"],
    status: json["status_id"],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game_id": gameId,
    "game_name": gameName,
    "title": title,
    "description": description,
    "min_points": minPoints,
    "max_points": maxPoints,
    "user_points": userPoints,
    "user_achievement": userAchievement?.toJson(),
    "next_achievement": nextAchievement,
    "status_id": status,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };
}