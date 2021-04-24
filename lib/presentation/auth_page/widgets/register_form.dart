import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../application/auth_bloc/auth_bloc.dart';
import '../../../application/auth_bloc/login_register_bloc/loginregister_bloc.dart';
import '../../../utils/utils.dart';
import '../../res/res.dart';
import '../providers/auth_mode_provider.dart';
import '../providers/register_form_provider.dart';
import 'switch_text.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final isRegisterMode =
        Provider.of<AuthModeProvider>(ctx, listen: false).authMode ==
            AuthMode.register;

    return BlocConsumer<LoginregisterBloc, LoginregisterState>(
      listenWhen: (_, __) => isRegisterMode,
      buildWhen: (_, __) => isRegisterMode,
      listener: (ctx, state) {
        if (state is LoginregisterFailed) {
          FlushbarHelper.createError(message: state.failure.message).show(ctx);
        } else if (state is LoginregisterSuccess) {
          ctx.read<AuthBloc>().add(const CheckAuth());
        }
      },
      builder: (ctx, state) {
        return ChangeNotifierProvider(
          create: (ctx) => RegisterFormProvider(),
          child: const MyRegisterForm(),
        );
      },
    );
  }
}

class MyRegisterForm extends StatelessWidget {
  const MyRegisterForm();

  @override
  Widget build(BuildContext ctx) {
    final provider = Provider.of<RegisterFormProvider>(ctx);
    final state = ctx.watch<LoginregisterBloc>().state;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SingleChildScrollView(
        child: Form(
          autovalidateMode: provider.showErrorMessage
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8.percentOf(width),
            ).copyWith(
              top: 2.5.percentOf(ctx.screenHeight),
            ),
            child: Column(
              children: [
                InputFields(width: width),
                IgnorePointer(
                  ignoring: state is LoginregisterLoading,
                  child: RegisterBtn(width: width),
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
        ),
      );
    });
  }
}

class RegisterBtn extends StatelessWidget {
  const RegisterBtn({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext ctx) {
    final provider = Provider.of<RegisterFormProvider>(ctx);

    return RaisedButton(
      disabledTextColor: AppTheme.disabledTextColor,
      onPressed: !provider.isFormFilled
          ? null
          : () {
              provider.enableErrorMessages();
              if (!provider.isFormValid) return null;

              ctx.read<LoginregisterBloc>().add(
                    RegisterButtonPressed(
                      name: provider.name,
                      email: provider.email,
                      password: provider.password,
                      confirmPassword: provider.confirmPassword,
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
      child: const Text(Strings.register),
    );
  }
}

class InputFields extends StatelessWidget {
  const InputFields({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext ctx) {
    final provider = Provider.of<RegisterFormProvider>(ctx);

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
            initialValue: provider.name,
            decoration: const InputDecoration(
              labelText: Strings.nameFieldPlaceholder,
              prefixIcon: Icon(Icons.person),
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) => provider.update(newName: value),
            validator: (_) => provider.nameValidMessage,
          ),
          SizedBox(height: 1.7.percentOf(ctx.screenHeight)),
          TextFormField(
            initialValue: provider.email,
            decoration: const InputDecoration(
              labelText: Strings.emailFieldPlaceholder,
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => provider.update(newEmail: value),
            validator: (value) => provider.emailValidMessage,
          ),
          SizedBox(height: 1.7.percentOf(ctx.screenHeight)),
          TextFormField(
            initialValue: provider.password,
            decoration: const InputDecoration(
              labelText: Strings.passwordFieldPlaceholder,
              prefixIcon: Icon(Icons.security),
            ),
            obscureText: true,
            validator: (value) => provider.passwordValidMessage,
            onChanged: (value) => provider.update(newPassword: value),
          ),
          SizedBox(height: 1.7.percentOf(ctx.screenHeight)),
          TextFormField(
            initialValue: provider.confirmPassword,
            decoration: const InputDecoration(
              labelText: Strings.passwordConfirmFieldPlaceholder,
              prefixIcon: Icon(Icons.security),
            ),
            obscureText: true,
            validator: (value) => provider.confirmPasswordValidMessage,
            onChanged: (value) => provider.update(newConfirmPassword: value),
          ),
        ],
      ),
    );
  }
}
