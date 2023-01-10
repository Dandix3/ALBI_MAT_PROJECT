import '../../utils/http/data-access/api.service.dart';
import '../models/game.dart';

class GameService {
  static const String apiEndpoint = 'games';

  static Future<Object?> getGameByScan(String scan) async {
    final response = await ApiService.autorizedGet('$apiEndpoint/scan', {
      'scan': scan,
    });

    if (response.statusCode == 200) {
      return Game.fromObject(response.data);
    } else {
      return response.message;
    }
  }

  Future<Object?> addGameToLibrary(int gameId) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/add/$gameId', {});

    if (response.statusCode == 200) {
      return Game.fromObject(response.data);
    } else {
      return response.message;
    }
  }
}