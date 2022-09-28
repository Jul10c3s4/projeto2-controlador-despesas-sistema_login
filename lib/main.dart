import 'package:controlador_despesas/domain/despesas.dart';
import 'package:controlador_despesas/pages/adicionardespesa.dart';
import 'package:controlador_despesas/pages/destaque_page.dart';
import 'package:controlador_despesas/pages/login.dart';
import 'package:controlador_despesas/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  //parei no minuto 31
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("pt", "BR")
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: <String, WidgetBuilder>{
        '/homepage':(context) => const DestaquePage(),
        '/splash': (context) => const SplashSreen(rota: '/homepage'),
        '/add_despesa':(context) => const AddDespesa(),
        '/login': (context) => const Login()
      } 
       
    );
  }
}
