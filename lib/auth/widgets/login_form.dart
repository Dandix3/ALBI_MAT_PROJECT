import 'package:albi_hry/auth/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);

    void login() {
      if (_formKey.currentState!.validate()) {
        authService
            .login(_emailController.text, _passwordController.text)
            .then((value) {
              if (value) {
                Navigator.of(context).pop();
              }
        });
      }
    }

    textFormField(
        {required String label,
        required TextEditingController controller,
        String? Function(String?)? validator,
        textInputAction = TextInputAction.none,}) {
      return Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.background,
        ),
        child: TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: theme.colorScheme.primary),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(3, 191, 215, 1.0)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(3, 191, 215, 1.0)),
            ),
          ),
          validator: validator,
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          textFormField(
            label: 'Email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Zadejte email';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10),
          textFormField(
            label: 'Heslo',
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Zadejte heslo';
              }
              return null;
            },
          ),
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
          ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.primary,
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Přihlásit se',
                style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.primary,
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Registrovat se',
                style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          const Text(
            'Nebo se přihlásit pomocí',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
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
      ),
    );
  }
}
