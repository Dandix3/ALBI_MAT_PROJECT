import 'package:albi_hry/config/colors.dart';
import 'package:albi_hry/auth/screens/login_screen.dart';
import 'package:albi_hry/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/services/auth.service.dart';

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
      ],
      child: MaterialApp(
        title: 'Alby hry',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: AlbiColors.primaryColorBlue,
            secondary: AlbiColors.primaryColorRed,
            tertiary: AlbiColors.primaryColorYellow,
            background: AlbiColors.backgroundColorLight,
          ),
          backgroundColor: AlbiColors.backgroundColorDark,
          appBarTheme: const AppBarTheme(
            backgroundColor: AlbiColors.backgroundColorLight,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AlbiColors.backgroundColorLight,
          ),
        ),
        home: const MainScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          MainScreen.routeName: (ctx) => const MainScreen(),
        },
      ),
    );
  }
}