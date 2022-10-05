import 'package:controlador_despesas/domain/despesas.dart';
import 'package:controlador_despesas/pages/adicionardespesa.dart';
import 'package:controlador_despesas/pages/destaque_page.dart';
import 'package:controlador_despesas/pages/login.dart';
import 'package:controlador_despesas/pages/splash_screen.dart';
import 'package:controlador_despesas/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FirebaseAuthApp();
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget FirebaseAuthApp() {
    FirebaseAuthAppRoutes Rotas = FirebaseAuthAppRoutes();
    return MaterialApp(
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: [Locale("pt", "BR")],
            debugShowCheckedModeBanner: false,
            initialRoute: "/login",
            routes: Rotas.routes);
  }
}
