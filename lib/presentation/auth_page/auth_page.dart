import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../application/auth_bloc/login_register_bloc/loginregister_bloc.dart';
import '../../injection.dart';
import '../../utils/utils.dart';
import '../res/res.dart';
import 'widgets/widgets.dart';

class AuthPage extends StatelessWidget {
  static String routeName = '/auth-page';

  const AuthPage();

  @override
  Widget build(BuildContext ctx) {
    return BlocProvider(
      create: (ctx) => getIt<LoginregisterBloc>(),
      child: const MyAuthPage(),
    );
  }
}

class MyAuthPage extends StatelessWidget {
  const MyAuthPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    bool isKeyboardVisible() => MediaQuery.of(ctx).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundContainer(),
            const ImageAvatar(assetImage: Images.doctor),
            AppName(),
            AuthCardContainer(),
            if (!isKeyboardVisible()) ...[
              const Align(
                alignment: Alignment.bottomCenter,
                child: SocialMedia(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ForgetPwdBtn extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 6.percentOf(ctx.screenWidth),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        Strings.forgetPasswordString,
        style: AppTheme.textlinkStyle.copyWith(
          fontSize: 4.percentOf(ctx.screenWidth),
        ),
      ),
    );
  }
}

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: kToolbarHeight,
      child: Text(
        Strings.appName,
        style: GoogleFonts.rancho(
          fontSize: 10.percentOf(ctx.screenWidth),
          color: Theme.of(ctx).primaryColor,
        ),
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColorLight,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0, 1],
        ),
      ),
    );
  }
}

class AuthCardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: 81.percentOf(ctx.screenHeight),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AuthCard(),
            SizedBox(height: 0.8.percentOf(ctx.screenWidth)),
            ForgetPwdBtn(),
          ],
        ),
      ),
    );
  }
}
