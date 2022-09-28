import 'package:controlador_despesas/domain/despesa_helper.dart';
import 'package:controlador_despesas/domain/despesas.dart';
import 'package:controlador_despesas/pages/homepage.dart';
import 'package:controlador_despesas/pages/subtiposDespesas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({super.key});

  @override
  State<DespesasPage> createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  DespesaHelper helper = DespesaHelper();
  List<Despesas> despesas = [];
  List<String> tiposDespesas = [
    'Casa',
    'Saúde',
    'Educação',
    "Trabalho",
    "Diversão"
  ];
  List<String> imagens = [
    "assets/images/casa.png",
    "assets/images/saude.png",
    "assets/images/educacao.png",
    "assets/images/trabalho.png",
    "assets/images/diversao.png",
  ];

  void initState() {
    super.initState();
    _getAllDespesas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Despesas Cadastradas",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Color(0xFF373737),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF6D656),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          itemCount: tiposDespesas.length,
          itemBuilder: (context, index) {
            return _CardDespesas(context, index);
          }),
    );
  }

  Widget _CardDespesas(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        SubtiposDespesas(tipoDespesa: tiposDespesas[index]))));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFAEF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${tiposDespesas[index]}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Image.asset(imagens[index].toString()),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  void _getAllDespesas() {
    helper.getAllDespesas().then((list) {
      setState(() {
        despesas = list;
      });
    });
  }
}
