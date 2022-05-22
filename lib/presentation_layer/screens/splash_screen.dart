import 'dart:async';
import 'package:flutter/material.dart';
import 'package:posts/constants/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String user = '';

  @override
  void didChangeDependencies() {
    getUser();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacementNamed(
        context,
        //navigate to different page (login/home)
        user != '' ? Variables.tabsScreen : Variables.loginScreen,
      ),
    );
    super.didChangeDependencies();
  }

  getUser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    user = sharedPref.getString(Variables.userEmail) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
