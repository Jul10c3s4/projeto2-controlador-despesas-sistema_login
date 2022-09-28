import 'package:controlador_despesas/domain/despesas.dart';
import 'package:controlador_despesas/pages/despesas_page.dart';
import 'package:controlador_despesas/pages/estatisticas_page.dart';
import 'package:controlador_despesas/pages/homepage.dart';
import 'package:controlador_despesas/pages/perfil.dart';
import 'package:controlador_despesas/widgets/card_despesas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'adicionardespesa.dart';

class DestaquePage extends StatefulWidget {
  const DestaquePage({super.key});

  @override
  State<DestaquePage> createState() => _DestaquePageState();
}

class _DestaquePageState extends State<DestaquePage> {
  int indexselected = 0;

  List pages = [
    const HomePage(),
    const Perfil(),
    const DespesasPage(),
    const EstatisticasPage(),
  ];
  List<Despesas> despesas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexselected],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF373737),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFFF3D16A),
        currentIndex: indexselected,
        onTap: (index) {
          setState(() {
            indexselected = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Despesas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Estatíticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }
}
