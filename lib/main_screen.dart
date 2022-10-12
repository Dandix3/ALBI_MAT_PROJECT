import 'package:albi_hry/auth/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/screens/login_screen.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main_screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Albi hry'),
        actions: [
          IconButton(
            onPressed: () {
              if (authService.isAuthenticated) {
                //authService.logout();
              } else {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  'Albi hry',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 20),
                Text(
                  'Vítejte v aplikaci Albi hry',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Domů',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Hry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
