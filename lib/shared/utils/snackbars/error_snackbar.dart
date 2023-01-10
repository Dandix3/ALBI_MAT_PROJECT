import 'package:flutter/material.dart';
export 'package:albi_hry/shared/utils/snackbars/error_snackbar.dart';

void throwError({required BuildContext context, required String title, String? message, List<String>? errors}) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 10),
      backgroundColor: theme.errorColor,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 16),
          ),
          if (message != null)
            Text(
              message,
              style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 16),
            ),
          if (errors != null)
            for (var error in errors)
              Text(
                error,
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
        ],
      ),
    ),
  );
}