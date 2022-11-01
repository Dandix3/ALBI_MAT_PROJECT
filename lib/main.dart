import 'package:albi_hry/auth/screens/register.screen.dart';
import 'package:albi_hry/auth/screens/login.screen.dart';
import 'package:albi_hry/main.screen.dart';
import 'package:albi_hry/user/screens/user.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/services/auth.service.dart';
import 'config/theme.dart';
import 'user/services/user.service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(create: (ctx) => UserService()),
      ],
      child: MaterialApp(
        title: 'Alby hry',
        theme: albi_theme,
        home: const MainScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          MainScreen.routeName: (ctx) => const MainScreen(),
          UserScreen.routeName: (ctx) => const UserScreen(),
        },
      ),
    );
  }
}