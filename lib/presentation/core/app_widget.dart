import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth_bloc/auth_bloc.dart';
import '../auth_page/auth_page.dart';
import '../home_page/home_page.dart';
import '../res/res.dart';
import '../splash_screen/splash_screen.dart';
import 'routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: AppTheme.lightTheme,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (ctx, state) {         
          if (state is AuthInitial) {
            return const SplashScreen();
          } else if (state is Unauthenticated) {
            return const AuthPage();
          } else {
            return const HomePage();
          }
        },
      ),
      routes: routes,
    );
  }
}
