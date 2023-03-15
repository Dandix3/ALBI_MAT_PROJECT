import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/club/models/club.dart';
import '../providers/club.provider.dart';
import 'club_card.dart';

class GroupList extends StatelessWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final clubProvider = Provider.of<ClubProvider>(context);

    return Container(
      height: 100,
      width: size.width,
      child: FutureBuilder<List<Club>>(
        future: clubProvider.fetchAndSetNearbyClubs(1000, 10),
        builder: (context, snapchot) {
          if (snapchot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapchot.data!.length,
              itemBuilder: (context, index) {
                return ClubCard(
                  club: snapchot.data![index],
                );
              },
            );
          } else {
            if (snapchot.error != null) {
              return Center(
                child: Text("Něco se pokazilo"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        }
      )
    );
  }
}


