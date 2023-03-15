import 'package:albi_hry/app/pages/social_feat/widgets/club_members_list.dart';
import 'package:albi_hry/app/pages/user/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/club/models/club.dart';
import '../providers/club.provider.dart';

class ClubDetailScreen extends StatelessWidget {
  static const routeName = '/club-detail';

  final Club club;

  const ClubDetailScreen({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final clubProvider = Provider.of<ClubProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final sizeWithoutAppbar = size.height - AppBar().preferredSize.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(club.name, style: theme.textTheme.headline4),
          ),
          body: Container(
            // todo: předělat action buttony pro majitele a admina do appbaru
            height: size.height,
            child: Column(
              children: [
                Container(
                  height: sizeWithoutAppbar * 0.2,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              width: size.width * 0.4,
                              child: Text(
                                club.description ?? "No description",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Počet členů: ${club.members.length}"),
                              Text(club.address, style: theme.textTheme.subtitle2),
                              Text(club.city, style: theme.textTheme.subtitle2),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              club.owner.id == userProvider.user?.id
                                  ? IconButton(
                                onPressed: () {
                                  clubProvider.deleteClub(club.id, context).then((_) => Navigator.of(context).pop());
                                },
                                icon: Icon(Icons.delete_forever),
                                iconSize: 40,
                              )
                                  : club.members.any((element) =>
                              element.user.id == userProvider.user?.id)
                                  ? IconButton(
                                onPressed: () {
                                  clubProvider.leaveClub(club, context);
                                },
                                icon: Icon(Icons.remove_circle),
                                iconSize: 40,
                              )
                                  : IconButton(
                                onPressed: () {
                                  clubProvider.joinClub(club, context);
                                },
                                icon: Icon(Icons.add_circle),
                                iconSize: 40,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(tabs: [
                  Tab(text: "Akce"),
                  Tab(text: "Členové"),
                  Tab(text: "Chat"),
                ]),
                Container(
                  height: sizeWithoutAppbar * 0.68,
                  child: TabBarView(children: [
                    Icon(Icons.directions_car),
                    ClubMembersList(club: club, isAdmin: club.owner.id == userProvider.user?.id),
                    Icon(Icons.directions_bike),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
