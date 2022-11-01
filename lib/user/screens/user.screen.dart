import 'package:albi_hry/auth/services/auth.service.dart';
import 'package:albi_hry/main.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../services/user.service.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final userService = Provider.of<UserService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    Future<void> logout() async {
      print("logout");
      await authService.logout(userService).then((value) => Navigator.of(context).popUntil((route) => route.isFirst));
    }

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: const Center(child: Text('Profil')),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: TextButton(
                  onPressed:logout,
                  child: const Text('Odhlásit se'),
                ),
              ),
            ];
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://img.freepik.com/premium-vector/person-avatar-design_24877-38137.jpg?w=740"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "${userService.user!.name} ${userService.user!.surname}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Container(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.7),
                child: Text(
                  DateFormat('dd.MM.yyyy').format(userService.user!.createdAt),
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
