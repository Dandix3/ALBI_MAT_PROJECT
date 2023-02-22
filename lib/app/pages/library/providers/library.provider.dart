import 'package:albi_hry/app/widgets/snackbars/error_snackbar.dart';
import 'package:albi_hry/data/repositories/auth/data-access/auth.service.dart';
import 'package:albi_hry/data/repositories/game/data-access/game.service.dart';
import 'package:albi_hry/data/repositories/library/data-access/library.service.dart';
import 'package:flutter/material.dart';

import 'package:albi_hry/common/game/models/game.dart';


class LibraryProvider extends ChangeNotifier {
  static const String apiEndpoint = 'userGames';

  final GameService _gameService = GameService();

  List<Game> _games = [];

  List<Game> get games => _games;

  LibraryProvider() {
    AuthService.getToken().then((token) {
      if (token != null) {
        LibraryService.getLibrary().then((games) {
          if (games != null) {
            _games = games;
            notifyListeners();
          } else {
            LibraryService.getLibraryFromLocal().then((games) {
              if (games != null) {
                _games = games;
                notifyListeners();
              }
            });
          }
        });
      }
    });
  }

  Future<void> fetchAndSetLibrary() async {
    final response = await LibraryService.getLibrary();
    _games = response!;
    notifyListeners();
  }

  Future<void> getLibraryFromLocal() async {
    final library = await LibraryService.getLibraryFromLocal();
    _games = library!;
    notifyListeners();
  }

  Future<void> clearLibrary() async {
    _games = [];
    notifyListeners();
  }

  void setLibraryData(List<Game> data) {
    _games = data;
    notifyListeners();
  }

  Future<Game?> fetchGame(String barcode, BuildContext context) async {
    return await GameService.getGameByScan(barcode).then((value) {
          if (value is Game) {
            return value;
            } else {
              throwError(context: context, title: value.toString());
            }
        });
  }

  Future<void> addGame(Game game) async {
    final response = await _gameService.addGameToLibrary(game.ksp);
    if (response is Game) {
      _games.add(response);
      notifyListeners();
    }
  }

  void _addGame(Game game) {
    _games.add(game);
    LibraryService.updateGamesInLibrary(_games);
    notifyListeners();
  }
}