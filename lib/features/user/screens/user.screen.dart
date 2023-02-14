import 'package:albi_hry/features/auth/providers/auth.provider.dart';
import 'package:albi_hry/features/user/providers/user.provider.dart';
import 'package:albi_hry/main-sceen/main.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../library/providers/library.provider.dart';
import '../widgets/profile_header.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthProvider>(context);
    final libraryProvider = Provider.of<LibraryProvider>(context);

    Future<void> logout() async {
      await authService.logout().then((value) => Navigator.of(context)
          .pushNamedAndRemoveUntil(
              MainScreen.routeName, (Route<dynamic> route) => false));
    }

    num getAchievementsCount() {
      num count = 0;
      libraryProvider.games.forEach((game) {
        count += game.achievements!.length - 1; //todo: -1 is a temporary; kvůli tomu achievementu který má pokračovat
      });
      return count;
    }

    num getAchievementsUserCount() {
      num count = 0;
      libraryProvider.games.forEach((game) {
        game.achievements!.forEach((element) {
          if (element.userPoints == element.maxPoints && element.minPoints == 0) {
            count++;
          }
        });
      });
      return count;
    }

    return SingleChildScrollView(
      child: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => auth.isAuthenticated
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(),
                    const SizedBox(height: 20),
                    Container(
                      width: size.width,
                      height: size.height * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Počet vlastněných her"),
                          const SizedBox(height: 10),
                          Container(
                            width: size.width * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  height: 10,
                                ),
                                FractionallySizedBox(
                                  widthFactor: 1 / 350 * 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(libraryProvider.games.length.toString()),
                                Text("350"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Počet splněných úspěchů"),
                          const SizedBox(height: 10),
                          Container(
                            width: size.width * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  height: 10,
                                ),
                                FractionallySizedBox(
                                  widthFactor: 1 / getAchievementsCount() * getAchievementsUserCount(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getAchievementsUserCount().toString()),
                                Text(getAchievementsCount().toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Nastavení'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: ElevatedButton(
                          onPressed: logout, child: const Text('Odhlásit se')),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Center(
            heightFactor: 39,
            child: Text(
              'Pro zobrazení profilu se prosím přihlašte',
              style: theme.textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }
}

// Scaffold(
// backgroundColor: theme.backgroundColor,
// appBar: AppBar(
// title: Center(child: Text('Profil', style: theme.textTheme.headline4)),
// actions: [
// PopupMenuButton(
// position: PopupMenuPosition.under,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10),
// ),
// itemBuilder: (context) {
// return [
// PopupMenuItem(
// onTap: logout,
// child: TextButton.icon(
// icon: const Icon(Icons.logout),
// onPressed: logout,
// label: const Text('Odhlásit se'),
// ),
// ),
// PopupMenuItem(
// onTap: () {},
// child: TextButton.icon(
// icon: const Icon(Icons.settings),
// onPressed: () {},
// label: const Text('Nastavení'),
// ),
// ),
// ];
// },
// ),
// ],
// ),
// body:
