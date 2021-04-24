import 'package:flutter/material.dart';

import '../../res/res.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({
    Key key,
  }) : super(key: key);

  @override
  _AnimatedHeartState createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  AnimationController _heartAnimationController;
  Animation<double> _heartAnimation;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _heartAnimation = Tween(begin: 60.0, end: 90.0).animate(
      CurvedAnimation(
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn,
        parent: _heartAnimationController,
      ),
    );
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return AnimatedBuilder(
      animation: _heartAnimation,
      builder: (ctx, child) {
        return SizedBox(
          child: Image.asset(
            Images.heart2,
            height: _heartAnimation.value,
          ),
        );
      },
    );
  }
}
