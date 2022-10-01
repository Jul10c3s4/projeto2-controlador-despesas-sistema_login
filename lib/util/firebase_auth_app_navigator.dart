import 'package:flutter/material.dart';

class FirebaseAuthAppNavigator {
  static void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/homepage");
  }
}
