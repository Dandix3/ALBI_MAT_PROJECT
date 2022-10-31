import 'package:albi_hry/auth/screens/register.screen.dart';
import 'package:albi_hry/config/colors.dart';
import 'package:albi_hry/auth/screens/login.screen.dart';
import 'package:albi_hry/main.screen.dart';
import 'package:albi_hry/user/screens/user.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/services/auth.service.dart';
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
        theme: ThemeData.dark().copyWith( // možná appbar hodit průhledy jak HBO appka
          useMaterial3: true,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: AlbiColors.primaryColorBlue,
            secondary: AlbiColors.primaryColorRed,
            tertiary: AlbiColors.primaryColorYellow,
            background: AlbiColors.backgroundColorLight,
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: AlbiColors.primaryColorRed,
            textTheme: ButtonTextTheme.primary,
          ),
          backgroundColor: AlbiColors.backgroundColorDark,
          appBarTheme: const AppBarTheme(
            backgroundColor: AlbiColors.backgroundColorLight,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AlbiColors.backgroundColorLight,
            selectedIconTheme: IconThemeData(color: AlbiColors.primaryColorYellow),
            selectedItemColor: AlbiColors.primaryColorYellow,
          ),
        ),
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