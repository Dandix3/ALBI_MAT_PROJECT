import 'package:albi_hry/features/game/screens/game_detail.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/providers/game.provider.dart';
import '../providers/library.provider.dart';
import 'game_tile.dart';

class GamesList extends StatelessWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final libraryProvider = Provider.of<LibraryProvider>(context);
    final gameProvider = Provider.of<GameProvider>(context);
    final theme = Theme.of(context);

    String _getPercentage(int gameIndex) {
      num allPoints = 0;
      int allUserPoints = 0;
      libraryProvider.games[gameIndex].achievements!.forEach((element) {
        if (element.minPoints == 0) {
          allPoints += element.maxPoints;
          allUserPoints += element.userPoints;
        }
      });
      return (allUserPoints / allPoints).toStringAsFixed(2);
    }

    return ListView.separated(
      itemCount: libraryProvider.games.length,
      itemBuilder: (ctx, i) => GameTile(
        title: libraryProvider.games[i].name,
        imageUrl: "https://cdn.alza.cz/ImgW.ashx?fd=f5&cd=ZA012",
        percentage: _getPercentage(i),
        onTap: () {
          gameProvider.selectGame(libraryProvider.games[i]);
          Navigator.of(context).pushNamed(GameDetailScreen.routeName);
        },
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.transparent,
        height: 10,
      ),
    );
  }
}
