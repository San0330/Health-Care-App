import 'package:flutter/material.dart';

import '../../presentation/res/strings.dart';

class Failure {
  final String message;

  static String SERVER_FAILURE_MSG = Strings.serverFailureMsg;
  static String NO_INTERNET_CONNECTION = Strings.noInternetConnection;

  const Failure({@required this.message}) : assert(message != null);

  @override
  String toString() => 'Failure(message: $message)';
}
