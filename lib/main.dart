import 'package:controlador_despesas/domain/despesas.dart';
import 'package:controlador_despesas/pages/adicionardespesa.dart';
import 'package:controlador_despesas/pages/destaque_page.dart';
import 'package:controlador_despesas/pages/login.dart';
import 'package:controlador_despesas/pages/splash_screen.dart';
import 'package:controlador_despesas/store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  //parei na aula 24 no minuto 18
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
        create: (_) => LoginStore(),
        child: MaterialApp(
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: [Locale("pt", "BR")],
            debugShowCheckedModeBanner: false,
            initialRoute: "/login",
            routes: <String, WidgetBuilder>{
              '/homepage': (context) => const DestaquePage(),
              '/splash': (context) => const SplashSreen(rota: '/homepage'),
              '/add_despesa': (context) => const AddDespesa(),
              '/login': (context) => const Login()
            }));
  }
}
