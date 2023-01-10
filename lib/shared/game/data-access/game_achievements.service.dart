import 'dart:convert';

import 'package:albi_hry/shared/utils/http/models/http_response.dart';

import '../../utils/http/data-access/api.service.dart';
import '../models/game_achievement.dart';

class GameAchievementsService {
  static const String apiEndpoint = 'game-achievements';

  static Future<List<GameAchievement>> getGameAchievementsByGameId(
      int gameId) async {
    final response = await ApiService.autorizedGet('$apiEndpoint/$gameId', {});

    return List<GameAchievement>.from(
        response.data.map((x) => GameAchievement.fromObject(x)));
  }

  static Future<HttpResponse> updateGameAchievement(GameAchievement gameAchievement, List<int> friendIds) async {
    final response = await ApiService.autorizedPut('$apiEndpoint/${gameAchievement.userAchievement!.id}', {
      'points': gameAchievement.userPoints.toString(),
      'friend_ids': jsonEncode(friendIds),
    });

    return response;
  }
}
