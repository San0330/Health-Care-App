import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../application/auth_bloc/auth_bloc.dart';
import '../../../application/auth_bloc/login_register_bloc/loginregister_bloc.dart';
import '../../../utils/utils.dart';
import '../../res/res.dart';
import '../providers/auth_mode_provider.dart';
import '../providers/login_form_provider.dart';
import 'switch_text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final isLoginMode =
        Provider.of<AuthModeProvider>(ctx, listen: false).authMode ==
            AuthMode.login;

    return BlocConsumer<LoginregisterBloc, LoginregisterState>(
      listenWhen: (_, __) => isLoginMode,
      buildWhen: (p, c) => isLoginMode && c is! LoginregisterSuccess,
      listener: (ctx, state) {
        if (state is LoginregisterFailed) {
          FlushbarHelper.createError(message: state.failure.message).show(ctx);
        } else if (state is LoginregisterSuccess) {
          ctx.read<AuthBloc>().add(const CheckAuth());
        }
      },
      builder: (ctx, state) {
        return ChangeNotifierProvider<LoginFormProvider>(
          create: (ctx) => LoginFormProvider(),
          child: MyLoginForm(),
        );
      },
    );
  }
}

class MyLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final LoginFormProvider provider = Provider.of<LoginFormProvider>(ctx);
    final state = ctx.watch<LoginregisterBloc>().state;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return Form(
          autovalidateMode: provider.showErrorMessage
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8.percentOf(width),
            ).copyWith(top: 2.5.percentOf(ctx.screenHeight)),
            child: Column(
              children: [
                LoginInputFields(width: width),
                IgnorePointer(
                  ignoring: state is LoginregisterLoading,
                  child: LoginButton(width: width),
                ),
                Divider(thickness: 0.3.percentOf(ctx.screenHeight)),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 1.percentOf(ctx.screenHeight),
                  ),
                  child: state is LoginregisterLoading
                      ? const LinearProgressIndicator()
                      : const SwitchText(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoginInputFields extends StatelessWidget {
  final double width;

  const LoginInputFields({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final LoginFormProvider provider = Provider.of<LoginFormProvider>(ctx);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.percentOf(width),
        vertical: 1.percentOf(ctx.screenHeight),
      ),
      alignment: Alignment.center,
      color: AppTheme.backgroundColor2.withOpacity(0.2),
      child: Column(
        children: [
          TextFormField(
            initialValue: provider.email,
            decoration: const InputDecoration(
              labelText: Strings.emailFieldPlaceholder,
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => provider.update(newEmail: value),
            validator: (_) => provider.emailValidMessage,
          ),
          SizedBox(height: 1.8.percentOf(ctx.screenHeight)),
          TextFormField(
            initialValue: provider.password,
            decoration: const InputDecoration(
              labelText: Strings.passwordFieldPlaceholder,
              prefixIcon: Icon(Icons.security),
            ),
            obscureText: true,
            validator: (_) => provider.passwordValidMessage,
            onChanged: (value) => provider.update(newPassword: value),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext ctx) {
    final provider = Provider.of<LoginFormProvider>(ctx);

    return RaisedButton(
      disabledTextColor: AppTheme.disabledTextColor,
      onPressed: !provider.isFormFilled
          ? null
          : () {
              provider.enableErrorMessages();
              if (!provider.isFormValid) return;

              ctx.read<LoginregisterBloc>().add(
                    LoginButtonPressed(
                      email: provider.email,
                      password: provider.password,
                    ),
                  );
            },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.percentOf(width),
        vertical: 1.percentOf(ctx.screenHeight),
      ),
      color: Theme.of(ctx).primaryColor,
      textColor: Theme.of(ctx).primaryTextTheme.button.color,
      child: const Text(Strings.login),
    );
  }
}
