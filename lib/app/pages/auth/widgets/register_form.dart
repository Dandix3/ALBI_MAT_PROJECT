import 'package:albi_hry/app/main/main.screen.dart';
import 'package:albi_hry/app/pages/auth/providers/auth.provider.dart';
import 'package:albi_hry/app/utils/validations/auth-validation.dart';
import 'package:albi_hry/app/widgets/loading-widget/loading.provider.dart';
import 'package:albi_hry/app/widgets/snackbars/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_container.dart';
import 'text_field_form.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _againPasswordController = TextEditingController();

  final _emailController = TextEditingController();

  final _nameController = TextEditingController();

  final _surnameController = TextEditingController();

  final _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);

    Future<void> register() async {
      if (_formKey.currentState!.validate()) {
        loadingProvider.setLoading(true);
        await authProvider
            .register(
                _emailController.text,
                _passwordController.text,
                _nameController.text,
                _surnameController.text,
                _nicknameController.text,)
            .then((value) {
          loadingProvider.setLoading(false);
          if (value.status) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                MainScreen.routeName, (Route<dynamic> route) => false);
          } else {
            var errors = value.errors?.map((e) => e).toList();
            throwError(
                context: context,
                title: "Registrace se nezdařila",
                errors: errors);
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
                return AuthValidators.validateEmail(value);
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _nameController,
              label: 'Jméno',
              validator: (value) {
                return AuthValidators.validateName(value);
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _surnameController,
              label: 'Příjmení',
              validator: (value) {
                return AuthValidators.validateSurname(value);
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _nicknameController,
              label: 'Přezdívka',
              validator: (value) {
                return AuthValidators.validateNickname(value);
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
            ),
            TextFieldForm(
              controller: _passwordController,
              label: 'Heslo',
              validator: (value) {
                return AuthValidators.validatePassword(value);
              },
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: true,
            ),
            TextFieldForm(
              controller: _againPasswordController,
              label: 'Opakujte heslo',
              validator: (value) {
                return AuthValidators.validatePasswordConfirmation(value, _passwordController.text);
              },
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: register,
            child: const Text('Registrovat se'),
          ),
        ),
      ],
    );
  }
}
