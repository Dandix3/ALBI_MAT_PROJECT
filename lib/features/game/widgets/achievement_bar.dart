import 'package:albi_hry/shared/game/models/game_achievement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.provider.dart';

class AchievementBar extends StatelessWidget {
  GameAchievement achievement;

  AchievementBar({Key? key, required this.achievement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: gameProvider.selectedAchievement == achievement
            ? theme.colorScheme.background
            : theme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(achievement.title),
              const Spacer(),
              achievement.userAchievement!.statusId == 4 ? Icon(Icons.circle, color: Colors.red, size: 10) : Container(),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 10,
              ),
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                widthFactor: 1 / achievement.maxPoints * achievement.userPoints,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(achievement.minPoints.toString()),
              Text(achievement.userPoints.toString()),
              Text(achievement.maxPoints.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
