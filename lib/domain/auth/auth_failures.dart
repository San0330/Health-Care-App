import 'package:flutter/foundation.dart';

import '../../presentation/res/strings.dart';
import '../core/failures.dart';

class AuthFailure extends Failure {
  static String CACHE_FAILURE_MSG = Strings.cacheFailureMsg;
  static String EMAIL_PWD_FAILURE_MSG = Strings.emailPwdFailureMsg;
  static String EMAIL_ALREADY_USED_MSG = Strings.emailAlreadyUsedMsg;

  const AuthFailure({@required String message})
      : assert(message != null),
        super(message: message);
}
