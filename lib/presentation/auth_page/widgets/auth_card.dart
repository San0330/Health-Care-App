import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../res/res.dart';
import '../providers/auth_mode_provider.dart';
import 'login_form.dart';
import 'register_form.dart';

class AuthCard extends StatelessWidget {
  const AuthCard();

  @override
  Widget build(BuildContext ctx) {
    return ChangeNotifierProvider(
      create: (ctx) => AuthModeProvider(),
      child: const _MyAuthCard(),
    );
  }
}

class _MyAuthCard extends StatelessWidget {
  const _MyAuthCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final _authMode = Provider.of<AuthModeProvider>(ctx).authMode;
    final logger = getLogger("MyAuthCard");

    logger.i("build() called");
    logger.i("$_authMode");

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 6.percentOf(ctx.screenWidth),
      ),
      color: AppTheme.backgroundColor2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: AnimatedCrossFade(
        firstChild: IgnorePointer(
          ignoring: _authMode == AuthMode.register,
          child: const LoginForm(),
        ),
        secondChild: IgnorePointer(
          ignoring: _authMode == AuthMode.login,
          child: const RegisterForm(),
        ),
        crossFadeState: _authMode == AuthMode.login
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
