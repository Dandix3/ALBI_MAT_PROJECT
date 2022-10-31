import 'package:albi_hry/auth/services/auth.service.dart';
import 'package:albi_hry/auth/widgets/form_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../user/services/user.service.dart';
import './text_field_form.dart';

import '../screens/register.screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);
    final theme = Theme.of(context);

    Future<void> login() async{
      if (_formKey.currentState!.validate()) {
        print('login');
        await authService
            .login(_emailController.text, _passwordController.text, userService)
            .then((value) {
          if (value) {
            Navigator.of(context).pop();
          }
        });
      }
    }

    return Column(
      children: [
        FormContainer(formKey: _formKey, children: [
          TextFieldForm(
            controller: _emailController,
            label: 'Email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email je povinný';
              }
              return null;
            },
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          TextFieldForm(
            controller: _passwordController,
            label: 'Heslo',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Heslo je povinné';
              }
              return null;
            },
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
        ]),
        Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.5),
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Zapomenuté heslo',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: login,
            child: const Text('Přihlásit se')
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
            child: const Text('Registrovat se'),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Stack(
            children: [
              Divider(
                color: theme.colorScheme.primary,
                thickness: 1,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: theme.backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Nebo se přihlásit pomocí',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/facebook_login_icon.png',
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/google_login_icon.jpg',
                fit: BoxFit.cover,
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
