import 'dart:async';

import 'package:albi_hry/app/widgets/snackbars/success_snackbar.dart';
import 'package:albi_hry/common/notifications/models/achievement_action.dart';
import 'package:albi_hry/data/helpers/http/models/http_response.dart';
import 'package:albi_hry/data/repositories/notifications/data-access/notification.service.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<AchievementAction> _achievementActions = [];

  List<AchievementAction> get achievementActions => _achievementActions;

  NotificationProvider() {
    fetchAndSetAchievementActions();
    Timer _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      fetchAndSetAchievementActions();
    });
  }

  Future<void> fetchAndSetAchievementActions() async {
    await _notificationService.getAchievementActions().then((value) {
      if (value.statusCode == 200) {
        _setAchievementActions(value);
        notifyListeners();
      } else {

      }
    });
  }

  Future<void> acknowledgeAchievementAction(int id, BuildContext context) async {
    await _notificationService.acknowledgeAchievementAction(id).then((value) {
      if (value.statusCode == 200) {
        throwSuccess(title: 'Úspěch potvrzen', context: context);
        _setAchievementActions(value);
        notifyListeners();
      } else {

      }
    });
  }

  Future<void> rejectAchievementAction(int id) async {
    await _notificationService.rejectAchievementAction(id).then((value) {
      if (value.statusCode == 200) {
        _setAchievementActions(value);
        notifyListeners();
      } else {

      }
    });
  }

  void _setAchievementActions(HttpResponse response) {
    _achievementActions = response.data.map<AchievementAction>((json) => AchievementAction.fromObject(json)).toList();
  }
}