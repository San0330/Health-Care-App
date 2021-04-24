import 'package:flutter/material.dart';

import '../../res/styling.dart';
import 'search_delegate.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: true,
      backgroundColor: AppTheme.backgroundColor2,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: Scaffold.of(context).openDrawer,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
