import 'package:albi_hry/common/game/models/game.dart';

class Library {
  List<Game>? games;

  Library({this.games});

  factory Library.fromObject(dynamic data) {
    return Library(
      games: data['games'] != null ? (data['games'] as List).map((i) => Game.fromObject(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "games": games != null ? List<dynamic>.from(games!.map((x) => x.toJson())) : null,
  };


}