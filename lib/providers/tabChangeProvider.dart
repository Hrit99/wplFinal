import 'package:flutter/material.dart';
import 'package:wplappgui/controllers/homeScreenController.dart';
import 'package:wplappgui/models/tabTiles.dart';

class TabChangeProvider with ChangeNotifier {
  String _selectedTab;

  void setSelectedTab(String c, bool notify) {
    _selectedTab = c;
    if (notify) {
      Duration d = Duration(seconds: 1);
      Curve curve = Curves.easeOut;
      homeScreenCarouselController.animateToPage(
          tabtiles.indexWhere((element) => element == _selectedTab),
          duration: d,
          curve: curve);
      notifyListeners();
    }
  }

  String get getSelectedTab {
    return _selectedTab;
  }
}
