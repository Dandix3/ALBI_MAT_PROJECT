import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
    if (value == true) {
      Future.delayed(const Duration(seconds: 6), () {
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  static LoadingProvider of(BuildContext context) {
    return Provider.of<LoadingProvider>(context, listen: false);
  }
}