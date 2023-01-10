import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  bool isForm = true;

  TextFieldForm(
      {Key? key,
      required this.label,
      required this.obscureText,
      required this.keyboardType,
      required this.controller,
      this.validator,
      this.isForm = true,
      required this.textInputAction})
      : super(key: key);

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: widget.isForm ? 80 : null,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          TextFormField(
            obscureText: showPassword ? false : widget.obscureText,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.white10,
              filled: true,
              labelText: widget.label,
              labelStyle: TextStyle(color: Colors.white),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    )
                  : null,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white60),
              ),
              errorStyle: TextStyle(color: theme.errorColor, fontSize: 14),
            ),
            validator: widget.validator,
            keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}
