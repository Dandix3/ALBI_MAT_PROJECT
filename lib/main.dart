import 'package:albi_hry/features/auth/providers/auth.provider.dart';
import 'package:albi_hry/features/game/providers/game.provider.dart';
import 'package:albi_hry/features/game/screens/game_detail.screen.dart';
import 'package:albi_hry/features/library/providers/library.provider.dart';
import 'package:albi_hry/features/notifications/providers/notification.provider.dart';
import 'package:albi_hry/features/notifications/screens/notification.screen.dart';
import 'package:albi_hry/features/user/providers/user.provider.dart';
import 'package:albi_hry/shared/user/models/user.dart';
import 'package:albi_hry/shared/utils/loading-widget/loading.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';

import 'features/user/providers/user-friend.provider.dart';
import 'main-sceen/main.screen.dart';
import 'features/auth/screens/login.screen.dart';
import 'features/auth/screens/register.screen.dart';
import 'features/user/screens/user.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => UserFriendProvider()),
        ChangeNotifierProvider(create: (ctx) => GameProvider()),
        ChangeNotifierProvider(create: (ctx) => LoadingProvider()),
        ChangeNotifierProvider(create: (ctx) => LibraryProvider()),
        ChangeNotifierProvider(create: (ctx) => NotificationProvider()),
        ChangeNotifierProxyProvider2<UserProvider, LibraryProvider, AuthProvider>(
            create: (ctx) => AuthProvider(null, null),
            update: (ctx, userProvider, libraryProvider, auth) =>
                AuthProvider(
                    userProvider, libraryProvider)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alby hry',
        theme: albi_theme,
        initialRoute: '/main_screen',
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          MainScreen.routeName: (ctx) => const MainScreen(),
          UserScreen.routeName: (ctx) => const UserScreen(),
          GameDetailScreen.routeName: (ctx) => const GameDetailScreen(),
          NotificationScreen.routeName: (ctx) => const NotificationScreen(),
        },
      ),
    );
  }
}
