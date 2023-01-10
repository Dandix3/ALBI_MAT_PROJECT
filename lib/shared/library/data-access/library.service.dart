
import 'package:albi_hry/shared/game/models/game.dart';
import 'package:albi_hry/shared/storage/data-access/local_storage.service.dart';

import '../../utils/http/data-access/api.service.dart';

class LibraryService {
  static const String apiEndpoint = 'user-games';

  static Future<List<Game>?> getLibrary() async {
    final response = await ApiService.autorizedGet(apiEndpoint, null);
    await LocalStorage.saveData('library', response.data);
    if (response.statusCode == 200) {
      return response.data.map<Game>((x) => Game.fromObject(x)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Game>?> getLibraryFromLocal() async {
    final library = await LocalStorage.getData('library');
    if (library == null) {
      return null;
    }
    return (library as List).map((i) => Game.fromObject(i)).toList();
  }

  static Future<void> clearLibrary() async {
    await LocalStorage.removeData('library');
  }

  static Future<void> updateGamesInLibrary(List<Game> games) async {
    await LocalStorage.saveData('library', games);
  }

}