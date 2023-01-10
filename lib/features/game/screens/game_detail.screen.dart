import 'package:albi_hry/features/game/providers/game.provider.dart';
import 'package:albi_hry/features/game/widgets/achievement_bar.dart';
import 'package:albi_hry/features/game/widgets/request_friend_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../user/providers/user-friend.provider.dart';

class GameDetailScreen extends StatefulWidget {
  static const routeName = '/game-detail';

  const GameDetailScreen({Key? key}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final userFriendProvider = Provider.of<UserFriendProvider>(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // if (gameProvider.game == null) {
    //   Navigator.of(context).pushReplacementNamed('/main_screen');
    // }

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(gameProvider.game!.name, style: theme.textTheme.headline4),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn.alza.cz/ImgW.ashx?fd=f5&cd=ZA012"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  color: Colors.yellow,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text("Úspěchy", style: theme.textTheme.headline6),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: gameProvider.achievements!.length,
                itemBuilder: (ctx, i) => GestureDetector(
                  onTap: () {
                    gameProvider
                        .selectAchievement(gameProvider.achievements![i]);
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => Container(
                        height: 50,
                        color: theme.colorScheme.background,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: size.width * 0.2,
                              child: IconButton(
                                  onPressed: () {
                                    gameProvider.minusOneAchievement(
                                        gameProvider.achievements![i]!);
                                  },
                                  highlightColor: theme.colorScheme.primary,
                                  icon: Icon(Icons.remove)),
                            ),
                            SizedBox(
                              width: size.width * 0.2,
                              child: IconButton(
                                  onPressed: () {
                                    gameProvider.plusOneAchievement(
                                        gameProvider.achievements![i]!);
                                  },
                                  highlightColor: theme.colorScheme.primary,
                                  icon: Icon(Icons.add)),
                            ),
                          ],
                        ),
                      ),
                      barrierColor: Colors.black.withOpacity(0),
                      clipBehavior: Clip.antiAlias,
                      isScrollControlled: true,
                    ).whenComplete(() {
                      showDialog(
                          context: context,
                          builder: (ctx) => Container(
                                width: 100,
                                child: AlertDialog(
                                  title: Text("Vyberte přítele pro potvrzení",
                                      style: theme.textTheme.headline6),
                                  content: Container(
                                    height: 200,
                                    width: 100,
                                    child: ListView.separated(
                                      itemBuilder: (context, i) {
                                        return RequestFriendCheckbox(friend: userFriendProvider.friends[i].friend!);
                                      },
                                      itemCount:
                                          userFriendProvider.friends.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Divider(
                                            color: theme.colorScheme.background,
                                            thickness: 1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK",
                                          style: theme.textTheme.bodyText1),
                                    ),
                                  ],
                                ),
                              )).whenComplete(() {
                        gameProvider.updateAchievement(gameProvider.achievements![i]);
                        gameProvider.selectAchievement(null);
                      });
                    });
                  },
                  child: AchievementBar(
                    achievement: gameProvider.achievements![i],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.transparent,
                  height: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
