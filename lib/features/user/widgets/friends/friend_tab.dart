import 'package:albi_hry/shared/user/enums/friend_status_type.dart';
import 'package:flutter/material.dart';


class FriendTab extends StatelessWidget {

  final FriendStatusType friendStatusType;
  final Function changeTab;
  final bool active;
  final String title;

  const FriendTab({Key? key, required this.friendStatusType, required this.changeTab, required this.active, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        changeTab();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
            children: [
              Text(title, style: theme.textTheme.headline5),
              const SizedBox(
                height: 5,
              ),
              active ? Container(
                height: 5,
                width: 70,
                decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    )
                ),
              ) :  const SizedBox(height: 5, width: 70,),
            ]
        ),
      ),
    );
  }
}
