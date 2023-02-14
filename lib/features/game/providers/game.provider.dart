import 'package:albi_hry/shared/game/data-access/game_achievements.service.dart';
import 'package:albi_hry/shared/game/models/game_achievement.dart';
import 'package:flutter/material.dart';

import 'package:albi_hry/shared/game/models/game.dart';

import '../../../shared/game/models/user_achievement.dart';

class GameProvider with ChangeNotifier {
  static const String apiEndpoint = 'games';

  Game? _game;
  List<GameAchievement>? _achievements;
  GameAchievement? _selectedAchievement;


  int _count = 0;
  /* Id přátelů kteří mají potvrdit achievement */
  List<int> _requestFriendsToCheck = [];

  Game? get game => _game;
  List<GameAchievement>? get allAchievements => _achievements;

  List<GameAchievement>? get achievements => _achievements?.where((element) => element.minPoints == 0).toList(); //todo: opravit zobrazování achievementů aby se zobrazovali ti první

  GameAchievement? get selectedAchievement => _selectedAchievement;

  void selectGame(Game game) {
    _game = game;
    _achievements = game.achievements;
    notifyListeners();
  }


  void selectAchievement(GameAchievement? achievement) {
    _selectedAchievement = achievement;
    _count = achievement?.userPoints ?? 0;
    notifyListeners();
  }

  void addFriendToCheck(int id) {
    _requestFriendsToCheck.add(id);
  }

  void removeFriendToCheck(int id) {
    _requestFriendsToCheck.remove(id);
  }

  void plusOneAchievement(GameAchievement achievement) {
    if (_selectedAchievement != null && _selectedAchievement!.userPoints < _selectedAchievement!.maxPoints) {
      _selectedAchievement!.userPoints++;
      notifyListeners();
    }
  }

  void minusOneAchievement(GameAchievement achievement) {
    if (_selectedAchievement != null && _selectedAchievement!.userPoints > 0) {
      _selectedAchievement!.userPoints -= 1;
      // if (_selectedAchievement!.currentValue <= 0) {
      //   _selectedAchievement!.currentValue = 0;
      //   _selectedAchievement!.isCompleted = false;
      //   _selectedAchievement!.completedAt = null;
      //   GameAchievementsService.updateAchievement(_selectedAchievement!);
      // }
      notifyListeners();
    }
  }

  Future<void> updateAchievement(GameAchievement achievement) async {
    if (achievement.userPoints != _count && _requestFriendsToCheck.isNotEmpty) {
      await GameAchievementsService.updateGameAchievement(achievement, _requestFriendsToCheck).then((value) {
        if (value.statusCode == 200) {
          _achievements!.where((element) => element.id == achievement.id).first.userAchievement = UserAchievement.fromObject(value.data);
          notifyListeners();
        }
      });
      _requestFriendsToCheck = [];
    }
  }
}