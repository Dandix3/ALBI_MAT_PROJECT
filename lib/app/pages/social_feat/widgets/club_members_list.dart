import 'package:albi_hry/common/club/models/club_member.dart';
import 'package:albi_hry/common/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../common/club/models/club.dart';
import '../providers/club.provider.dart';

class ClubMembersList extends StatelessWidget {
  final Club club;
  final bool isAdmin;

  const ClubMembersList({Key? key, required this.club, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clubProvider = Provider.of<ClubProvider>(context);

    return Container(
        child: ListView.builder(
      itemCount: club.members.length,
      itemBuilder: (context, index) {
        return ListTile(
          enabled: club.members[index].role < 1 &&  isAdmin,
          onLongPress: () {
            if (isAdmin) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Vyberte akci"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () {
                                clubProvider.acceptMember(club.members[index]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Přidat jako admina")),
                          TextButton(
                              onPressed: () {
                                clubProvider.acceptMember(club.members[index]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Přidat jako člena")),
                          TextButton(
                              onPressed: () {
                                clubProvider.removeMember(club.members[index].id).then((value) => value ? club.members.removeAt(index) : null);
                                Navigator.of(context).pop();
                              },
                              child: Text("Odebrat člena")),
                        ],
                      ),
                    );
                  });
            }
          },
          title: Text(club.members[index].user.nickname, style: theme.textTheme.headline6),
          subtitle: Text(
              "Členem od: " +
                  DateFormat("dd.MM.yy").format(club.members[index].createdAt),
              style: theme.textTheme.subtitle2),
          trailing: club.members[index].role == 0 ? Text("Čeká na vyřízení") : club.members[index].role == 1 ? Text("Člen") : club.members[index].role == 2 ? Text("Admin") : club.members[index].role == 3 ? Text("Majitel") : null,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network("https://picsum.photos/200"),
          ),
        );
      },
    ));
  }
}
