

class UserAchievement {
  final int id;
  final int achievementId;
  final int userId;
  final int statusId;
  final int points;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserAchievement({
    required this.id,
    required this.achievementId,
    required this.userId,
    required this.statusId,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAchievement.fromObject(Map<String, dynamic> object) {
    return UserAchievement(
      id: object['id'],
      achievementId: object['achievement_id'],
      userId: object['user_id'],
      statusId: object['status_id'],
      points: object['points'],
      createdAt: DateTime.parse(object['created_at']),
      updatedAt: DateTime.parse(object['updated_at']),
    );
  }

  Map<String, dynamic> toObject() {
    return {
      'id': id,
      'achievementId': achievementId,
      'userId': userId,
      'statusId': statusId,
      'points': points,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserAchievement.fromJson(Map<String, dynamic> json) => UserAchievement(
    id: json["id"],
    achievementId: json["achievement_id"],
    userId: json["user_id"],
    statusId: json["status_id"],
    points: json["points"],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "achievement_id": achievementId,
    "user_id": userId,
    "status_id": statusId,
    "points": points,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}