import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> children;
  final formKey;

  const FormContainer({Key? key, required this.children, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.background,
        ),
        child: Column(
          children: children,
        )
      ),
    );
  }
}
