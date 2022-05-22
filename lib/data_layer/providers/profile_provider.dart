import 'package:flutter/material.dart';
import 'package:posts/constants/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String _userEmail = "";

  String get userEmail => _userEmail;

  getUserEmail() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    _userEmail = sharedPref.getString(Variables.userEmail) ?? "";
    notifyListeners();
  }
}
