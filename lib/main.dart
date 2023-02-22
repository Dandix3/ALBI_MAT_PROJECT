import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/main/main.screen.dart';
import 'app/pages/auth/providers/auth.provider.dart';
import 'app/pages/auth/screens/login.screen.dart';
import 'app/pages/auth/screens/register.screen.dart';
import 'app/pages/game/providers/game.provider.dart';
import 'app/pages/game/screens/game_detail.screen.dart';
import 'app/pages/library/providers/library.provider.dart';
import 'app/pages/notifications/providers/notification.provider.dart';
import 'app/pages/notifications/screens/notification.screen.dart';
import 'app/pages/user/providers/user-friend.provider.dart';
import 'app/pages/user/providers/user.provider.dart';
import 'app/pages/user/screens/user.screen.dart';
import 'app/widgets/loading-widget/loading.provider.dart';
import 'config/theme.dart';


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
        ChangeNotifierProxyProvider4<UserProvider, LibraryProvider, UserFriendProvider, NotificationProvider, AuthProvider>(
            create: (ctx) => AuthProvider(null, null, null, null),
            update: (ctx, userProvider, libraryProvider, userFriendProvider, notificationProvider, prev) =>
               prev!..setProviders(userProvider, libraryProvider, userFriendProvider, notificationProvider))
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
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
