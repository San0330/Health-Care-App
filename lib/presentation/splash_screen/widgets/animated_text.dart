import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../application/auth_bloc/auth_bloc.dart';
import '../../../utils/utils.dart';
import '../../res/res.dart';

class AnimateText extends StatelessWidget {
  const AnimateText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return TyperAnimatedTextKit(
      text: const [
        Strings.splashString,
      ],
      speed: const Duration(milliseconds: 120),
      pause: const Duration(milliseconds: 40),
      isRepeatingAnimation: false,
      repeatForever: false,
      onFinished: () {
        ctx.read<AuthBloc>().add(const CheckAuth());
      },
      textStyle: GoogleFonts.rubik(
        color: Theme.of(ctx).primaryColor,
        fontSize: 4.5.percentOf(ctx.screenWidth),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
