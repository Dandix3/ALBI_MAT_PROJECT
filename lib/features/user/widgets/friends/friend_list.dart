import 'package:albi_hry/shared/user/enums/friend_status_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../shared/user/models/user-friend.dart';
import '../../providers/user-friend.provider.dart';

class UserFriendList extends StatelessWidget {
  final List<UserFriend> friends;
  final FriendStatusType friendStatusType;

  UserFriendList(
      {Key? key, required this.friends, required this.friendStatusType})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final userFriendProvider = Provider.of<UserFriendProvider>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: RefreshIndicator(
              onRefresh: () {
                return userFriendProvider.fetchAndSetFriends();
              },
              child: ListView.separated(
              itemBuilder: (context, index) {
                return Slidable(
                  key: Key('${friends[index].id.toString()} ${friendStatusType.toString()}'),
                  closeOnScroll: true,
                  startActionPane: FriendStatusType.incoming == friendStatusType
                      ? ActionPane(
                          extentRatio: 0.25,
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              onPressed: (ctx) {
                                userFriendProvider.declineFriendRequest(friends[index].id, context);
                              },
                              icon: Icons.delete_forever,
                              backgroundColor: theme.colorScheme.error,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                          ],
                        )
                      : null,
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: ScrollMotion(),
                    children: friendStatusType == FriendStatusType.accepted
                        ? [
                            SlidableAction(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              onPressed: (ctx) {
                                userFriendProvider.removeFriend(friends[index].id, context);
                              },
                              icon: Icons.delete_forever,
                              backgroundColor: theme.colorScheme.error,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                          ]
                        : friendStatusType == FriendStatusType.incoming ? [
                            SlidableAction(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              onPressed: (ctx) {
                                userFriendProvider.acceptFriendRequest(friends[index].id, context);
                              },
                              icon: Icons.check,
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                          ] : [
                            SlidableAction(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              onPressed: (ctx) {
                                userFriendProvider.removeFriend(friends[index].id, context);
                              },
                              icon: Icons.delete_forever,
                              backgroundColor: theme.colorScheme.error,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                          ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        NetworkImage('https://picsum.photos/200'),
                      ),
                      title: Text(
                        friends[index].friend!.nickname,
                        style: theme.textTheme.headline6,
                      ),
                      trailing: Container(
                        width: size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              friendStatusType == FriendStatusType.accepted
                                  ? 'Přátelé od '
                                  : friendStatusType == FriendStatusType.incoming
                                  ?  'Odesláno '
                                  : 'Odesláno ',
                              style: theme.textTheme.subtitle1,
                            ),
                            Text(
                              DateFormat('dd.MM.yy')
                                  .format(friends[index].createdAt),
                              style: theme.textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  child: Divider(
                    color: theme.colorScheme.background,
                    thickness: 1,
                  ),
                );
              },
              itemCount: friends.length,
            ),
      ),
    );
  }
}

// return Container(
// child: friends.isEmpty
// ? Center(
// child: Text(
// 'Žádní přátelé',
// style: theme.textTheme.headline6,
// ),
// )
// : ListView.separated(
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// leading: CircleAvatar(
// radius: 40,
// backgroundImage: NetworkImage('https://picsum.photos/200'),
// ),
// title: Text(
// friends[index].friend!.nickname,
// style: theme.textTheme.headline6,
// ),
// trailing: Container(
// width: size.width * 0.3,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text(
// 'Posláno ',
// style: theme.textTheme.subtitle1,
// ),
// Text(
// DateFormat('dd.MM.yy').format(friends[index].createdAt),
// style: theme.textTheme.subtitle1,
// ),
// ],
// ),
// ),
// ),
// );
// },
// separatorBuilder: (context, index) {
// return Container(
// child: Divider(
// color: theme.colorScheme.background,
// thickness: 1,
// ),
// );
// },
// itemCount: friends.length,
// ),
// );

// Container(
// margin: const EdgeInsets.all(10),
// child: Row(
// children: [
// Container(
// width: size.width * 0.15,
// height: size.width * 0.15,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage("https://picsum.photos/200"),
// fit: BoxFit.cover,
// ),
// shape: BoxShape.circle,
// color: theme.primaryColor,
// ),
// ),
// const SizedBox(
// width: 10,
// ),
// Text(
// friends[index].friend!.nickname,
// style: theme.textTheme.headline5,
// ),
// // created at
// const Spacer(),
// Text(
// 'Posláno: ${DateFormat('dd.MM.yy').format(friends[index].createdAt)}',
// style: theme.textTheme.subtitle2,
// ),
// ],
// ),
// );
