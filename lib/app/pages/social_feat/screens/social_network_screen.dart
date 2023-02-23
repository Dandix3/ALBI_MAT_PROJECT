import 'package:albi_hry/app/pages/social_feat/widgets/groups_list.dart';
import 'package:flutter/material.dart';

class SocialNetworkScreen extends StatelessWidget {
  const SocialNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          // search bar here
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: TextField(
                textInputAction: TextInputAction.search,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Vyhledat skupinu',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: size.width * 0.9,
            child: Text("Skupiny", style: theme.textTheme.headline5),
          ),
          const SizedBox(
            height: 8,
          ),
          GroupList(),

          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: size.width * 0.9,
            child: Text("Nastávající Akce", style: theme.textTheme.headline5),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
