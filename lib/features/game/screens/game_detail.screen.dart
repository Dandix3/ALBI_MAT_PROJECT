import 'package:albi_hry/features/game/providers/game.provider.dart';
import 'package:albi_hry/features/game/widgets/achievement_bar.dart';
import 'package:albi_hry/features/game/widgets/request_friend_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../user/providers/user-friend.provider.dart';

class GameDetailScreen extends StatefulWidget {
  static const routeName = '/game-detail';

  const GameDetailScreen({Key? key}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  int points = 0;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final userFriendProvider = Provider.of<UserFriendProvider>(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(gameProvider.game!.name, style: theme.textTheme.headline4),
        actions: [
          IconButton(
            onPressed: () {
              //show options dialog
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(size.width, 80, 0, 0),
                color: theme.primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                constraints: const BoxConstraints(maxWidth: 150),
                items: [
                  PopupMenuItem(
                    child: GestureDetector(
                      child: Row(
                        children: [
                          const Icon(Icons.star),
                          const SizedBox(width: 10),
                          Text("Ohodnotit", style: theme.textTheme.headline6),
                        ],
                      ),
                      onTap: () => {
                        Navigator.of(context).pop(),
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Ohodnotit hru",
                                style: theme.textTheme.headline4),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Zrušit",
                                    style: theme.textTheme.headline6),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Potvrdit",
                                    style: theme.textTheme.headline6),
                              ),
                            ],
                            content: Container(
                              width: 200,
                              height: 50,
                              child: Center(
                                child: RatingBar.builder(
                                  initialRating: 5,
                                  minRating: 0.5,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 35,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.delete_forever),
                        const SizedBox(width: 10),
                        Text("Odstranit", style: theme.textTheme.headline6),
                      ],
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        centerTitle: true,
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
                    setState(() {
                      points = gameProvider.achievements![i].userPoints;
                    });
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: theme.colorScheme.background,
                      builder: (ctx) => Container(
                        margin: const EdgeInsets.only(bottom: 25),
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
                                        gameProvider.achievements![i]);
                                  },
                                  highlightColor: theme.colorScheme.primary,
                                  icon: Icon(Icons.remove)),
                            ),
                            SizedBox(
                              width: size.width * 0.2,
                              child: IconButton(
                                  onPressed: () {
                                    gameProvider.plusOneAchievement(
                                        gameProvider.achievements![i]);
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
                    ).whenComplete(
                      () {
                        if (points != gameProvider.achievements![i].userPoints) {
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
                                    return RequestFriendCheckbox(
                                        friend: userFriendProvider
                                            .friends[i].friend!);
                                  },
                                  itemCount: userFriendProvider.friends.length,
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
                                    gameProvider.achievements![i].userPoints = points;
                                    gameProvider.selectAchievement(null);
                                  },
                                  child: Text("Zrušit",
                                      style: theme.textTheme.bodyText1),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    gameProvider.updateAchievement(
                                        gameProvider.achievements![i]);
                                    gameProvider.selectAchievement(null);
                                  },
                                  child: Text("Potvrdit",
                                      style: theme.textTheme.bodyText1),
                                ),
                              ],
                            ),
                          ),
                        ).whenComplete(
                            () => {
                              gameProvider.selectAchievement(null),
                              setState(() {
                                points = 0;
                              })
                            },
                        );
                        }
                        gameProvider.selectAchievement(null);
                      },
                    );
                  },
                  child: AchievementBar(
                    achievement: gameProvider.achievements![i]
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
