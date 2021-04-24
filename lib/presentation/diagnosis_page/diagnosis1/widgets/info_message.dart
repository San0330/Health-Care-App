import 'package:flutter/material.dart';

class InfoMessage extends StatelessWidget {
  const InfoMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Center(
              child: Text(
                "Tap on the list to select your symptom",
              ),
            )
          ],
        ),
      ),
    );
  }
}