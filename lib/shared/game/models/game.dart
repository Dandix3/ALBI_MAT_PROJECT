

import 'game_achievement.dart';

class Game {
  final int ksp;
  final String name;
  final int EAN;
  final String? klp;
  final String? cap;
  final DateTime releaseDate;
  final List<GameAchievement>? achievements;

  Game({
    required this.ksp,
    required this.name,
    required this.EAN,
    required this.klp,
    required this.cap,
    required this.releaseDate,
    this.achievements,
  });

  factory Game.fromObject(dynamic data) {
    return Game(
      ksp: data['ksp'],
      name: data['name'],
      EAN: data['EAN'],
      klp: data['klp'],
      cap: data['cap'],
      releaseDate: DateTime.parse(data['release_date']),
      achievements: data['achievements'] != null ? List<GameAchievement>.from(data['achievements'].map((x) => GameAchievement.fromObject(x))) : null,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    ksp: json["ksp"],
    name: json["name"],
    EAN: json["EAN"],
    klp: json["klp"],
    cap: json["cap"],
    releaseDate: DateTime.parse(json['release_date']),
    achievements: json['achievements'] != null ? List<GameAchievement>.from(json['achievements'].map((x) => GameAchievement.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "ksp": ksp,
    "name": name,
    "EAN": EAN,
    "klp": klp,
    "cap": cap,
    "release_date": releaseDate.toString(),
    "achievements": achievements != null ? List<dynamic>.from(achievements!.map((x) => x.toJson())) : null,
  };

}