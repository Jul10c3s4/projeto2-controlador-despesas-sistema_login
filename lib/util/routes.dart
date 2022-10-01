import 'package:flutter/cupertino.dart';

import '../pages/adicionardespesa.dart';
import '../pages/destaque_page.dart';
import '../pages/login.dart';
import '../pages/splash_screen.dart';

class FirebaseAuthAppRoutes {
  var routes = <String, WidgetBuilder>{
    '/homepage': (context) => const DestaquePage(),
    '/splash': (context) => const SplashSreen(rota: '/homepage'),
    '/add_despesa': (context) => const AddDespesa(),
    '/login': (context) => const Login()
  };
}
