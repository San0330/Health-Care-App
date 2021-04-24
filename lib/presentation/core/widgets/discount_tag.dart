import 'package:flutter/material.dart';

import '../../res/res.dart';

class DiscountTag extends StatelessWidget {
  final int discountRate;

  const DiscountTag({
    Key key,
    this.discountRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            color: AppTheme.dangerColor,            
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Text(
            "-${discountRate.toString()}%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
