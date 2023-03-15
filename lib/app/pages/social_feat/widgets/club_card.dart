import 'package:flutter/material.dart';

import '../../../../common/club/models/club.dart';
import '../screens/club_detail.screen.dart';

class ClubCard extends StatelessWidget {
  final Club club;

  const ClubCard({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ClubDetailScreen.routeName,
          arguments: club,
        );
      },
      child: Container(
          width: size.width * 0.32,
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: size.width * 0.32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: size.width * 0.32,
                  child: Center(
                    child: Text(
                      club.name,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}