import 'package:flutter/widgets.dart';

import '../../../utils/validators.dart';

class RegisterFormProvider with ChangeNotifier {
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

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

  void update({
    String newName,
    String newEmail,
    String newPassword,
    String newConfirmPassword,
  }) {
    email = newEmail?.trim() ?? email;
    password = newPassword ?? password;
    name = newName ?? name;
    confirmPassword = newConfirmPassword ?? confirmPassword;

    _isFormValid = validateEmail(email).isRight() &&
        validatePassword(password).isRight() &&
        validateConfirmPassword(password, confirmPassword).isRight() &&
        validateName(name).isRight();

    _isFormFilled = name.trim().isNotEmpty &&
        email.trim().isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;

    notifyListeners();
  }

  String get emailValidMessage =>
      validateEmail(email).fold((l) => l, (r) => null);

  String get passwordValidMessage =>
      validatePassword(password).fold((l) => l, (r) => null);

  String get nameValidMessage => validateName(name).fold((l) => l, (r) => null);

  String get confirmPasswordValidMessage =>
      validateConfirmPassword(password, confirmPassword)
          .fold((l) => l, (r) => null);
}
