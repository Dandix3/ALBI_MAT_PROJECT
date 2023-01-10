import 'package:albi_hry/features/user/widgets/friends/friend_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/user/enums/friend_status_type.dart';
import '../../auth/providers/auth.provider.dart';
import '../providers/user-friend.provider.dart';
import '../widgets/friends/friend_list.dart';

class FriendsScreen extends StatefulWidget {
  FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  FriendStatusType index = FriendStatusType.accepted;

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

    return Container(
      child: authProvider.isAuthenticated ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FriendTab(
                      friendStatusType: FriendStatusType.accepted,
                      changeTab: () {
                        changeTab(FriendStatusType.accepted);
                      },
                      active: index == FriendStatusType.accepted,
                      title: 'Přátelé',
                    ),
                    FriendTab(
                      friendStatusType: FriendStatusType.incoming,
                      changeTab: () {
                        changeTab(FriendStatusType.incoming);
                      },
                      active: index == FriendStatusType.incoming,
                      title: 'Žádosti',
                    ),
                    FriendTab(
                      friendStatusType: FriendStatusType.pending,
                      changeTab: () {
                        changeTab(FriendStatusType.pending);
                      },
                      active: index == FriendStatusType.pending,
                      title: 'Nevyřízené',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.8 - 50,
            child: index == FriendStatusType.accepted
                ? UserFriendList(friends: userFriendProvider.friends, friendStatusType: FriendStatusType.accepted)
                : index == FriendStatusType.incoming
                ? UserFriendList(
                friends: userFriendProvider.friendsRequests, friendStatusType: FriendStatusType.incoming)
                : UserFriendList(
                friends: userFriendProvider.friendsPending, friendStatusType: FriendStatusType.pending),
          ),
        ],
      ) : Center(
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
