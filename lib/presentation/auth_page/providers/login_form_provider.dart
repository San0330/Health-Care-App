import 'package:flutter/widgets.dart';

import '../../../utils/validators.dart';

class LoginFormProvider with ChangeNotifier {
  String email = "";
  String password = "";
  bool _showErrorMessage = false;
  bool _isFormValid = false;
  bool _isFormFilled = false;

  bool get isFormValid => _isFormValid;
  bool get isFormFilled => _isFormFilled;
  bool get showErrorMessage => _showErrorMessage;

  void enableErrorMessages() {
    _showErrorMessage = true;
    notifyListeners();
  }

  void update({String newEmail, String newPassword}) {
    email = newEmail ?? email;
    password = newPassword ?? password;

    _isFormValid =
        validateEmail(email).isRight() && validatePassword(password).isRight();

    _isFormFilled = email.trim().isNotEmpty && password.isNotEmpty;

    notifyListeners();
  }

  String get emailValidMessage =>
      validateEmail(email).fold((l) => l, (r) => null);

  String get passwordValidMessage =>
      validatePassword(password).fold((l) => l, (r) => null);
}
