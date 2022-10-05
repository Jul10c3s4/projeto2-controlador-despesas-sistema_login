import 'package:controlador_despesas/util/routes.dart';
import 'package:flutter/material.dart';

class FirebaseAuthApp extends StatefulWidget {
  const FirebaseAuthApp({super.key});

  @override
  State<FirebaseAuthApp> createState() => _FirebaseAuthAppState();
}

class _FirebaseAuthAppState extends State<FirebaseAuthApp> {
    FirebaseAuthAppRoutes Rotas = FirebaseAuthAppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            localizationsDelegates: [
              /*GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
             */ 
            ],
            supportedLocales: [Locale("pt", "BR")],
            debugShowCheckedModeBanner: false,
            initialRoute: "/login",
            routes: Rotas.routes);
  }
}