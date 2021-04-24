import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/contextx.dart';
import '../../../utils/numx.dart';
import '../../res/strings.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 1.percentOf(ctx.screenWidth),
        vertical: 1.5.percentOf(ctx.screenHeight),
      ),
      width: 80.percentOf(ctx.screenWidth),      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Strings.socialMediaConnectWithString,
            style: TextStyle(
              fontSize: 6.percentOf(ctx.screenWidth),
              color: Theme.of(ctx).primaryColor,
            ),
          ),
          SizedBox(
            height: 0.8.percentOf(ctx.screenHeight),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  size: 5.percentOf(ctx.screenHeight),
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: 5.percentOf(ctx.screenHeight),
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.google,
                  size: 5.percentOf(ctx.screenHeight),
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
