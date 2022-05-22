import 'package:flutter/material.dart';
import 'package:posts/presentation_layer/screens/splash_screen.dart';
import 'package:posts/presentation_layer/screens/tabs_screen.dart';
import 'package:posts/presentation_layer/screens/login_screen.dart';
import 'package:posts/presentation_layer/screens/sign_up_screen.dart';
import 'constants/variables.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case Variables.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Variables.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Variables.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case Variables.tabsScreen:
        return MaterialPageRoute(
          builder: (_) => TabsScreen(),
        );
    }
  }
}
