import 'package:albi_hry/features/auth/providers/auth.provider.dart';
import 'package:albi_hry/features/user/providers/user.provider.dart';
import 'package:albi_hry/main-sceen/main.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/profile_header.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final userService = Provider.of<UserProvider>(context);
    final authService = Provider.of<AuthProvider>(context);

    Future<void> logout() async {
      await authService.logout().then((value) => Navigator.of(context)
          .pushNamedAndRemoveUntil(
              MainScreen.routeName, (Route<dynamic> route) => false));
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
                      width: size.width * 0.9,
                      height: size.height * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
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
