import 'package:flutter/widgets.dart';

enum AuthMode { login, register }

class AuthModeProvider with ChangeNotifier {

  AuthMode _authMode = AuthMode.login;

  AuthMode get authMode => _authMode;

  void switchAuthMode() {
    _authMode == AuthMode.login
        ? _authMode = AuthMode.register
        : _authMode = AuthMode.login;

    notifyListeners();
  }
}
