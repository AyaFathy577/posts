import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool _showPass = false;
  bool _showConfirmPass = false;

  bool get showPass => _showPass;

  bool get showConfirmPass => _showConfirmPass;

  updateShowPass(bool value) async {
    _showPass = value;
    notifyListeners();
  }

  updateShowConfirmPass(bool value) async {
    _showConfirmPass = value;
    notifyListeners();
  }
}
