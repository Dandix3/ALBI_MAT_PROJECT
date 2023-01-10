import 'package:albi_hry/features/auth/providers/auth.provider.dart';
import 'package:albi_hry/features/library/screens/library.screen.dart';
import 'package:albi_hry/features/notifications/screens/notification.screen.dart';
import 'package:albi_hry/features/user/screens/friends_screen.dart';
import 'package:albi_hry/main-sceen/screen_type.dart';
import 'package:albi_hry/main-sceen/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:albi_hry/shared/utils/init_startup.dart';
import 'package:albi_hry/features/user/screens/user.screen.dart';
import 'package:albi_hry/features/auth/screens/login.screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScreenType screenType = ScreenType.Games;
  String barcode = '';

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    void pushNotificationPage() {
      authProvider.isLoggedIn().then((value) => {
            if (value)
              {Navigator.of(context).pushNamed(NotificationScreen.routeName)}
            else
              {Navigator.of(context).pushNamed(LoginScreen.routeName)}
          });
    }

    Future<Icon> getIcon() async {
      final asd = await authProvider.isLoggedIn();
      if (asd) {
        return Icon(Icons.notifications);
      } else {
        return Icon(Icons.login);
      }
    }

    return InitStartUp(
      onInit: () {
        authProvider.isLoggedIn();
      },
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/albi-logo.png',
                height: 25,
                color: theme.colorScheme.tertiary,
              ),
              screenType == ScreenType.Games
                  ? Text(
                      'Knihovna',
                      style: theme.textTheme.headline4,
                    )
                  : screenType == ScreenType.Nothing
                      ? Text(
                          'Not Implemented',
                          style: theme.textTheme.headline4,
                        )
                      : screenType == ScreenType.Friends
                          ? Text(
                              'Přátelé',
                              style: theme.textTheme.headline4,
                            )
                          : screenType == ScreenType.Profile
                              ? Text(
                                  'Profil',
                                  style: theme.textTheme.headline4,
                                )
                              : Text(
                                  'Not Implemented',
                                  style: theme.textTheme.headline4,
                                ),
              IconButton(
                onPressed: pushNotificationPage,
                icon: authProvider.isAuthenticated
                    ? const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: (screenType == ScreenType.Games)
              ? LibraryScreen()
              : (screenType == ScreenType.Nothing)
                  ? Text('Not Implemented')
                  : (screenType == ScreenType.Friends)
                      ? FriendsScreen()
                      : screenType == ScreenType.Profile
                          ? UserScreen()
                          : Text('Not Implemented'),
        ),
        floatingActionButton: FloatingActionBtn(screenType: screenType),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const [
            Icons.library_books_rounded,
            Icons.search,
            Icons.groups_outlined,
            Icons.person,
          ],
          backgroundColor: theme.colorScheme.background,
          activeIndex: screenType.index,
          gapLocation: GapLocation.center,
          activeColor: theme.colorScheme.tertiary,
          splashSpeedInMilliseconds: 400,
          splashColor: theme.colorScheme.tertiary,
          elevation: 150,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) =>
              setState(() => this.screenType = ScreenType.values[index]),
        ),
      ),
    );
  }
}
