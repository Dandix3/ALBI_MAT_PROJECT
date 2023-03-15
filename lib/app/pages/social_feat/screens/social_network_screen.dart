import 'package:albi_hry/app/pages/social_feat/widgets/groups_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/club.provider.dart';
import '../widgets/gps_map.dart';
import 'create_club.screen.dart';

class SocialNetworkScreen extends StatelessWidget {
  const SocialNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClubScreen(),
                  ));
                },
                child: Text("Vytvořit skupinu"),
              ),
              ElevatedButton(
                onPressed: () {
                  ;
                },
                child: Text("Moje skupiny"),
              ),
            ],
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //   child: ListTile(
          //     title: TextField(
          //       textInputAction: TextInputAction.search,
          //       style: TextStyle(color: Colors.white, fontSize: 18),
          //       decoration: InputDecoration(
          //         prefixIcon: Icon(Icons.search),
          //         hintText: 'Vyhledat skupinu',
          //         border: InputBorder.none,
          //         hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Skupiny v okolí", style: theme.textTheme.headline5),
              SizedBox(
                width: size.width * 0.2,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapWidget(),
                  ));
                },
                child: Text("Zobrazit vše"),
              ),
            ],
          ),
          GroupList(),

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Nastávající akce", style: theme.textTheme.headline5),
              SizedBox(
                width: size.width * 0.2,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapWidget(),
                  ));
                },
                child: Text("Zobrazit vše"),
              ),
            ],
          ),

          GroupList2(),
        ],
      ),
    );
  }
}

class GroupList2 extends StatelessWidget {
  const GroupList2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final clubProvider = Provider.of<ClubProvider>(context);

    return Container(
      height: 100,
      width: size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: size.width * 0.32,
            child: Card(
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Zapař D&D", style: theme.textTheme.headline6),
                  Text("Pardubice", style: theme.textTheme.subtitle1),
                  Text("20. 5. 2023", style: theme.textTheme.subtitle2),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.32,
            child: Card(
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text("Den deskovek ALBI", style: theme.textTheme.headline6, overflow: TextOverflow.ellipsis),
                  ),
                  Text("Praha", style: theme.textTheme.subtitle1),
                  Text("18. 8. 2023", style: theme.textTheme.subtitle2),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.32,
            child: Card(
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text("Deskovačka", style: theme.textTheme.headline6, overflow: TextOverflow.ellipsis),
                  ),
                  Text("Opava", style: theme.textTheme.subtitle1),
                  Text("14. 7. 2023", style: theme.textTheme.subtitle2),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.32,
            child: Card(
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text("Catan párty", style: theme.textTheme.headline6, overflow: TextOverflow.ellipsis),
                  ),
                  Text("Pardubice", style: theme.textTheme.subtitle1),
                  Text("7. 6. 2023", style: theme.textTheme.subtitle2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
