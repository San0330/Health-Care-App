import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const double _fabDimension = 56.0;

class AnimatedFloatingBtn extends StatefulWidget {
  final Widget toshow;

  const AnimatedFloatingBtn({
    Key key,
    this.toshow,
  }) : super(key: key);

  @override
  _AnimatedFloatingBtnState createState() => _AnimatedFloatingBtnState();
}

class _AnimatedFloatingBtnState extends State<AnimatedFloatingBtn> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: _transitionType,
      openBuilder: (context, _) {
        return widget.toshow;
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_fabDimension / 2),
        ),
      ),
      closedColor: Colors.blue,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: _fabDimension,
          width: _fabDimension,
          child: Center(
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
    );
  }
}
