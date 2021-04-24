import 'package:flutter/widgets.dart';

class TabChangeProvider extends ChangeNotifier {
  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  void changeTab(int newTabIndex) {
    _currentTabIndex = newTabIndex;
    notifyListeners();
  }
}
