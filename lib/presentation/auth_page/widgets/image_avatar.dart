import 'package:flutter/material.dart';
import 'package:pharma_app2/presentation/res/res.dart';
import '../../../utils/numx.dart';
import '../../../utils/contextx.dart';

class ImageAvatar extends StatelessWidget {
  final String assetImage;

  const ImageAvatar({@required this.assetImage}) : assert(assetImage != null);

  @override
  Widget build(BuildContext ctx) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 8.percentOf(ctx.screenHeight),
          right: 5.percentOf(ctx.screenWidth),
          child: Opacity(
            opacity: 0.25,
            child: CircleAvatar(
              radius: 30.percentOf(ctx.screenWidth),
              backgroundColor: AppTheme.backgroundColor1,
              child: Image(
                image: AssetImage(assetImage),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
