import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';
import '../res/res.dart';
import 'widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash-screen';

  const SplashScreen();

  @override
  Widget build(BuildContext ctx) {
    getLogger("SplashScreen").i("build() called");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 160,
                  height: 120,
                  child: const AnimatedHeart(),
                ),
                Positioned(
                  bottom: 0,
                  right: 22,
                  child: Icon(
                    FontAwesomeIcons.medkit,
                    color: Theme.of(ctx).primaryColor,
                    size: 14.percentOf(ctx.screenWidth),
                  ),
                ),
              ],
            ),
            Text(
              Strings.appName,
              style: GoogleFonts.damion(
                  color: Theme.of(ctx).primaryColor,
                  fontSize: 10.percentOf(ctx.screenWidth),
                  fontWeight: FontWeight.bold),
            ),
            const AnimateText(),
          ],
        ),
      ),
    );
  }
}
