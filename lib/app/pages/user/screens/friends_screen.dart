import 'package:albi_hry/common/user/enums/friend_status_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../auth/providers/auth.provider.dart';
import '../providers/user-friend.provider.dart';
import '../widgets/friends/friend_list.dart';

class FriendsScreen extends StatefulWidget {
  FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {
  FriendStatusType index = FriendStatusType.accepted;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userFriendProvider = Provider.of<UserFriendProvider>(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    void changeTab(FriendStatusType friendStatusType) {
      setState(() {
        index = friendStatusType;
      });
    }

    if (userFriendProvider.friendStatus == true) {
      setState(() {
        _tabController.index = 2;
      });
    }

    return Container(
      child: authProvider.isAuthenticated
          ? Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                child: Text('Přátelé'),
              ),
              Tab(
                child: Text('Žádosti'),
              ),
              Tab(
                child: Text('Nepřátelé'),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                UserFriendList(
                  friendStatusType: FriendStatusType.accepted,
                  friends: userFriendProvider.friends,
                ),
                UserFriendList(
                  friendStatusType: FriendStatusType.incoming,
                  friends: userFriendProvider.friendsRequests,
                ),
                UserFriendList(
                  friendStatusType: FriendStatusType.pending,
                  friends: userFriendProvider.friendsPending,
                ),
              ],
            ),
          ),
        ],
      )
          : Center(
              child: Text(
                'Pro zobrazení přátel se musíte přihlásit',
                style: theme.textTheme.headline6,
              ),
            ),
    );
  }
}

// Container(
// padding: const EdgeInsets.only(top: 20),
// decoration: BoxDecoration(
// color: theme.primaryColorLight,
// border: Border(
// bottom: BorderSide(
// color: theme.colorScheme.background,
// width: 1,
// ),
// ),
// ),
// child: Row(
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Container(
// margin: EdgeInsets.only(bottom: 0),
// padding: EdgeInsets.only(bottom: 0),
// child: Text('Přátelé', style: theme.textTheme.headline3),
// decoration: BoxDecoration(
// border: Border(
// bottom: BorderSide(
// color: theme.colorScheme.primary,
// width: 3,
// ),
// ),
// ),
// ),
// Container(
// margin: EdgeInsets.only(bottom: 0),
// padding: EdgeInsets.only(bottom: 0),
// child: Text('Žádosti', style: theme.textTheme.headline3),
// ),
// ],
// ),
// ),

// title: Container(
// padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
// height: MediaQuery.of(context).padding.top + 66,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Image.asset(
// 'assets/images/albi-logo.png',
// height: 25,
// color: theme.colorScheme.tertiary,
// ),
// IconButton(
// onPressed: () {
// },
// icon: const Icon(Icons.person),
// ),
// ],
// ),
// ),
