import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String title;

  const Heading({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10,left: 10),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
        ),
        Container(
          height: 3.0,
          width: 100,
          margin: const EdgeInsets.only(left: 10,bottom: 10),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
