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

    if (userFriendProvider.friendStatus == true) {
      setState(() {
        index = FriendStatusType.pending;
      });
    }

    return Container(
      child: authProvider.isAuthenticated
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Text('Přátelé',
                                    style: theme.textTheme.headline5),
                                onTap: () =>
                                    changeTab(FriendStatusType.accepted),
                              ),
                              GestureDetector(
                                child: Text('Žádosti',
                                    style: theme.textTheme.headline5),
                                onTap: () =>
                                    changeTab(FriendStatusType.incoming),
                              ),
                              GestureDetector(
                                child: Text('Nevyřízené',
                                    style: theme.textTheme.headline5),
                                onTap: () =>
                                    changeTab(FriendStatusType.pending),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                      height: 5,
                      width: index == FriendStatusType.accepted
                          ? 60
                          : index == FriendStatusType.incoming
                              ? 65
                              : 85,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      margin: EdgeInsets.only(
                        top: 43,
                        left: index == FriendStatusType.accepted
                            ? size.width * 0.08
                            : index == FriendStatusType.incoming
                                ? size.width * 0.38
                                : size.width * 0.7,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.8 - 50,
                  child: index == FriendStatusType.accepted
                      ? UserFriendList(
                          friends: userFriendProvider.friends,
                          friendStatusType: FriendStatusType.accepted)
                      : index == FriendStatusType.incoming
                          ? UserFriendList(
                              friends: userFriendProvider.friendsRequests,
                              friendStatusType: FriendStatusType.incoming)
                          : UserFriendList(
                              friends: userFriendProvider.friendsPending,
                              friendStatusType: FriendStatusType.pending),
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
