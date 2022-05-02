import 'package:flutter/material.dart';

class MenuSection extends ChangeNotifier {
  int _menu = 1;

  set menu(int value) {
    _menu = value;
    notifyListeners();
  }

  int get menu => _menu;
}
