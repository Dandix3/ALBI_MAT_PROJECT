import 'package:albi_hry/auth/services/auth.service.dart';
import 'package:albi_hry/shared/screens/init_startup.dart';
import 'package:albi_hry/user/screens/user.screen.dart';
import 'package:albi_hry/user/services/user.service.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/screens/login.screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return InitStartUp(
        onInit: () {
          authService.isLoggedIn(userService);
        },
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: const Text('Albi hry'),
            actions: [
              IconButton(
                onPressed: () {
                  if (authService.isAuthenticated) {
                    Navigator.of(context).pushNamed(UserScreen.routeName);
                  } else {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  }
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
          body: Center(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    child:
                        Text('Moje Knihovna'),
                  ),
                  const Spacer(),
                  Center(
                    child: Text('Knihovna je prázdná, \n přidejte si hru',)
                  ),
                  SizedBox(height: 100),
                  Transform.rotate(
                    angle: -3.14 / 6,
                    child: Container(
                      margin: const EdgeInsets.only(left: 150),
                        width: 200,
                        child: Image.asset('backgrounds/background-arrow.png', color: Colors.white,
                        ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: const [
              Icons.library_books_rounded,
              Icons.search,
              Icons.apps,
              Icons.favorite,
            ],
            backgroundColor: theme.colorScheme.background,
            activeIndex: index,
            gapLocation: GapLocation.center,
            activeColor: theme.colorScheme.secondary,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: (index) => setState(() => this.index = index),
          ),
        ));
  }
}
