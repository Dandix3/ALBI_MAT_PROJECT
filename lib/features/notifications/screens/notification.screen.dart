import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/notification.provider.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification_screen';

  const NotificationScreen({Key? key}) : super(key: key);

  get doNothing => (_) {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Oznámení', style: theme.textTheme.headline4),
      ),
      body: ListView.separated(
        itemCount: notificationProvider.achievementActions.length,
        itemBuilder: (context, index) {
          final points = int.parse(
                  notificationProvider.achievementActions[index].newState) -
              int.parse(
                  notificationProvider.achievementActions[index].prevState);
          final pointsCaller = points < 5
              ? 'body'
              : points < 2
                  ? 'bod'
                  : 'bodů';

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Slidable(
              key: ValueKey(index),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane( //todo: dost zajímavý feature
                //   onDismissed: () {},
                //   dismissThreshold: 0.5,
                //   key: ValueKey(index),
                // ),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    key: Key('delete' + index.toString()),
                    autoClose: true,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    onPressed: (_) {
                      notificationProvider.rejectAchievementAction(
                          notificationProvider.achievementActions[index].id);
                    },
                    icon: Icons.dangerous,
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    key: Key('accept' + index.toString()),
                    autoClose: true,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    onPressed: (_) {
                      notificationProvider.acknowledgeAchievementAction(
                          notificationProvider.achievementActions[index].id, context);
                    },
                    icon: Icons.check_circle_rounded,
                    backgroundColor: Colors.green,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ],
              ),
              child: Container(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  title: Text(
                      '${notificationProvider.achievementActions[index].friend.nickname} poslal žádost o potvrzení úspechu',
                      style: theme.textTheme.headline6),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: 'Ve hře ',
                          ),
                          TextSpan(
                            text: notificationProvider.achievementActions[index].achievement.gameName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " se posunul v úspěchu ",
                          ),
                          TextSpan(
                            text: notificationProvider.achievementActions[index].achievement.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " o ",
                          ),
                          TextSpan(
                            text: "$points ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: pointsCaller,
                          ),
                        ]
                      )
                    )
                  ),
                  trailing: Text(
                      DateFormat('dd. MM. yy').format(notificationProvider
                          .achievementActions[index].createdAt),
                      style: theme.textTheme.bodyText2),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: theme.colorScheme.background,
            thickness: 1,
            height: 0,
          );
        },
      ),
    );
  }
}
