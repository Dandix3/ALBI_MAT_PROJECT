import 'package:albi_hry/common/game/models/game.dart';
import 'package:albi_hry/data/helpers/http/data-access/api.service.dart';

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