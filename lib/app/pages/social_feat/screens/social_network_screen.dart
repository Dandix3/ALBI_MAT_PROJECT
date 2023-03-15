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
            children: [
              SizedBox(
                width: size.width * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClubScreen(),
                  ));
                },
                child: Text("Vytvořit skupinu"),
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
          //GroupList(),

        ],
      ),
    );
  }
}
