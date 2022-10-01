import 'package:controlador_despesas/pages/destaque_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../util/firebase_auth_app_navigator.dart';

class SplashSreen extends StatefulWidget {
  final String rota;
  const SplashSreen({super.key, required this.rota});

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void animacao() async {
    await Future.delayed(const Duration(seconds: 4));
    FirebaseAuthAppNavigator.goToLogin(context);
  }
}
