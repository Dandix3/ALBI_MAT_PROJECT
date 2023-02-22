import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: size.height * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: size.width * 0.2,
              height: size.width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/200"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            userProvider.user?.nickname ?? 'Anonym',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            width: size.width,
            child: Divider(
              color: theme.colorScheme.background,
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
//   return Row(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   ClipRRect(
//   borderRadius: BorderRadius.circular(100),
//   child: Container(
//   width: size.width * 0.2,
//   height: size.width * 0.2,
//   decoration: const BoxDecoration(
//   image: DecorationImage(
//   image: NetworkImage(
//   "https://img.freepik.com/premium-vector/person-avatar-design_24877-38137.jpg?w=740"),
//   fit: BoxFit.cover,
//   ),
//   ),
//   ),
//   ),
//   SizedBox(width: size.width * 0.1),
//   Column(
//   children: [
//   Text(
//   userService.user!.nickname,
//   style: const TextStyle(
//   fontSize: 20, fontWeight: FontWeight.bold),
//   ),
//   ],
//   ),
//   SizedBox(width: size.width * 0.1),
//   IconButton(
//   onPressed: () {},
//   icon: const Icon(Icons.edit),
//   ),
//   ],
//   ),
// }
// }
}
