import 'package:flutter/material.dart';

class TabsProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  updateIndex(int val) {
    _index = val;
    notifyListeners();
  }
}
