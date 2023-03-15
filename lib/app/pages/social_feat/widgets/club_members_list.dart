import 'package:albi_hry/common/club/models/club_member.dart';
import 'package:albi_hry/common/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClubMembersList extends StatelessWidget {
  final List<ClubMember> clubMembers;

  const ClubMembersList({Key? key, required this.clubMembers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        child: ListView.builder(
      itemCount: clubMembers.length,
      itemBuilder: (context, index) {
        return ListTile(
          title:
              Text(clubMembers[index].user.nickname, style: theme.textTheme.headline6),
          subtitle: Text(
              "Členem od: " +
                  DateFormat("dd.MM.yy").format(clubMembers[index].createdAt),
              style: theme.textTheme.subtitle2),
          trailing: clubMembers[index].role == 0 ? Text("Čeká na vyřízení") : clubMembers[index].role == 1 ? Text("Člen") : clubMembers[index].role == 2 ? Text("Admin") : clubMembers[index].role == 3 ? Text("Majitel") : null,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network("https://picsum.photos/200"),
          ),
        );
      },
    ));
  }
}
