import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../res/res.dart';

import '../providers/auth_mode_provider.dart';

class SwitchText extends StatelessWidget {
  const SwitchText();

  @override
  Widget build(BuildContext context) {
    final AuthModeProvider _authModeProvider =
        Provider.of<AuthModeProvider>(context);

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 6.percentOf(width),
          ),
          children: [
            TextSpan(
              text: _authModeProvider.authMode == AuthMode.login
                  ? Strings.switchRegister
                  : Strings.switchLogin,
            ),
            TextSpan(
              text: _authModeProvider.authMode == AuthMode.login
                  ? Strings.register
                  : Strings.login,
              style: AppTheme.textlinkStyle.copyWith(
                fontSize: 6.5.percentOf(width),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _authModeProvider.switchAuthMode(),
            ),
          ],
        ),
      );
    });
  }
}
