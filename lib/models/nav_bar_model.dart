import 'package:flutter/material.dart';

class NavigationBarModel extends ChangeNotifier {
  int selectedItem = 0;

  void changeTab(int tab) {
    selectedItem = tab;
    notifyListeners();
  }
}
