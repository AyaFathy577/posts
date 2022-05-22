import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _showPass = false;

  bool get showPass => _showPass;

  updateShowPass(bool value) async {
    _showPass = value;
    notifyListeners();
  }
}
