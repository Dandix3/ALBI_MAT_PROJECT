import 'package:albi_hry/auth/widgets/form_container.dart';
import 'package:albi_hry/auth/widgets/text_field_form.dart';
import 'package:albi_hry/main.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user/services/user.service.dart';
import '../services/auth.service.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  final _passwordController = TextEditingController();
  final _againPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _nicknameController = TextEditingController();

  void showPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);

    Future<void> register() async {
      if (_formKey.currentState!.validate()) {
        await authService
            .register(
                _emailController.text,
                _passwordController.text,
                _nameController.text,
                _surnameController.text,
                _nicknameController.text,
                userService)
            .then((value) {
          if (value.status) {
            Navigator.of(context).pushNamed(MainScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: theme.errorColor,
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.vertical,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Registrace se nezdařila',
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                    Text(
                      value.errors.toString(),
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
            );
          }
        });
      }
    }

    return Column(
      children: [
        FormContainer(
          formKey: _formKey,
          children: [
            TextFieldForm(
              controller: _emailController,
              label: 'Email',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email je povinný';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _nameController,
              label: 'Jméno',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Jméno je povinné';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _surnameController,
              label: 'Příjmení',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Příjmení je povinné';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _nicknameController,
              label: 'Přezdívka',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Přezdívka je povinná';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
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
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: !_showPassword,
            ),
            TextFieldForm(
              controller: _againPasswordController,
              label: 'Opakujte heslo',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Heslo je povinné';
                }
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: !_showPassword,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: register,
            child: const Text('Register'),
          ),
        ),
      ],
    );
  }
}
