import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorsHandlerProvider with ChangeNotifier {
  static const String apiEndpoint = 'errors';

  Error _error = Error();

  Error get error => _error;

  void setError(Error error) {
    _error = error;
    notifyListeners();
  }

  void clear() {
    _error = Error();
    notifyListeners();
  }

  static ErrorsHandlerProvider of(BuildContext context) {
    return Provider.of<ErrorsHandlerProvider>(context, listen: false);
  }

}