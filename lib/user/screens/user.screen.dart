import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/user.service.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Consumer(
              builder: (context, UserService userService, child) {
                return Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Text(
                      'Profil',
                      style: theme.textTheme.headline1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Vítejte ${userService.user?.name}',
                      style: theme.textTheme.headline2,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
