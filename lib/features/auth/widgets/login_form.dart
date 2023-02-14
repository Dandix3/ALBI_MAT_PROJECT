import 'package:albi_hry/features/auth/providers/auth.provider.dart';
import 'package:albi_hry/shared/utils/validations/auth-validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:albi_hry/shared/utils/snackbars/error_snackbar.dart';
import '../../../main-sceen/main.screen.dart';
import '../../../shared/utils/loading-widget/loading.provider.dart';
import '../screens/register.screen.dart';
import 'form_container.dart';
import 'text_field_form.dart';

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
    final authProvider = Provider.of<AuthProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    final theme = Theme.of(context);

    Future<void> login() async{
      if (_formKey.currentState!.validate()) {
        loadingProvider.setLoading(true);
        await authProvider.login(_emailController.text, _passwordController.text).then((value) {
          loadingProvider.setLoading(false);
          if (value.status) {
            Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
          } else {
            var errors = value.errors?.map((e) => e).toList();
            throwError(context: context, title: "Přihlášení se nezdařilo", message: value.message);
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
              return AuthValidators.validateEmail(value);
            },
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          TextFieldForm(
            controller: _passwordController,
            label: 'Heslo',
            validator: (value) {
              return AuthValidators.validatePassword(value!);
            },
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            isForm: true,
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
