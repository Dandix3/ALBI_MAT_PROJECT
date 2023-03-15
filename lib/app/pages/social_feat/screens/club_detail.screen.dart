import 'package:albi_hry/app/pages/social_feat/widgets/club_members_list.dart';
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

    final sizeWithoutAppbar = size.height - AppBar().preferredSize.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(club.name, style: theme.textTheme.headline4),
          ),
          body: Container(
            height: size.height,
            child: Column(
              children: [
                Container(
                  height: sizeWithoutAppbar * 0.2,
                  child: Stack(
                    children: [
                      Expanded(
                        child: Padding(
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
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Počet členů: ${club.members?.length}"),
                                ),
                              ),
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
                              IconButton(
                                onPressed: () {
                                  clubProvider.joinClub(club.id).then((value) => club.members = value);
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
                  height: sizeWithoutAppbar * 0.7,
                  child: TabBarView(children: [
                    Icon(Icons.directions_car),
                    ClubMembersList(clubMembers: club.members!),
                    Icon(Icons.directions_bike),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
