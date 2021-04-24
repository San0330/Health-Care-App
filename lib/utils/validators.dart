import 'package:dartz/dartz.dart';

import '../presentation/res/strings.dart';

Either<String, Unit> validatePassword(String value) {
  if (value.isEmpty || value.length < 5) {
    return left(Strings.passwordFieldShort);
  }
  return right(unit);
}

Either<String, Unit> validateEmail(String value) {
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  if (!_emailRegExp.hasMatch(value)) {
    return left(Strings.emailFieldInvalid);
  }
  return right(unit);
}

Either<String, Unit> validateName(String value) {
  if (value.trim().isEmpty) {
    return left(Strings.nameFieldInvalid);
  }
  return right(unit);
}

Either<String, Unit> validateConfirmPassword(
    String password, String confirmPassword) {
  if (password == confirmPassword) {
    return right(unit);
  } else if (password.isEmpty) {
    /// invalid message is given by password field, so, not necessary to return invalid message
    return right(unit);
  } else {
    return left(Strings.confirmPasswordValidMsg);
  }
}
