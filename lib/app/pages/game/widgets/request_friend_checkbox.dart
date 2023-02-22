import 'package:albi_hry/app/pages/game/providers/game.provider.dart';
import 'package:albi_hry/common/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestFriendCheckbox extends StatefulWidget {

  final User friend;

  const RequestFriendCheckbox({Key? key, required this.friend}) : super(key: key);

  @override
  State<RequestFriendCheckbox> createState() => _RequestFriendToCheckState();
}

class _RequestFriendToCheckState extends State<RequestFriendCheckbox> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameProvider = Provider.of<GameProvider>(context);

    return CheckboxListTile(
      activeColor: theme.colorScheme.tertiary,
      secondary: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
            'https://picsum.photos/200'),
      ),
      title: Text(widget.friend.nickname,
        style: theme.textTheme.headline6,
      ),
      tileColor: Colors.transparent,
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          if (value != null && value) {
            gameProvider.addFriendToCheck(widget.friend.id);
          } else {
            gameProvider.removeFriendToCheck(widget.friend.id);
          }
          _isChecked = value!;
        });
      },
    );
  }
}
