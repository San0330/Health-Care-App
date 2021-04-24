import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tab_change_provider.dart';

class BottomAppbarHomeBtn extends StatelessWidget {
  const BottomAppbarHomeBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final tabChangeProvider = Provider.of<TabChangeProvider>(ctx);
    final _color =
        tabChangeProvider.currentTabIndex == 0 ? Colors.blue : Colors.grey;

    return Expanded(
      child: MaterialButton(
        minWidth: 40,
        onPressed: () => tabChangeProvider.changeTab(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              color: _color,
            ),
            Text(
              "Home",
              style: TextStyle(
                color: _color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}