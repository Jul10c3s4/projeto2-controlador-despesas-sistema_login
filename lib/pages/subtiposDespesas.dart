import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../domain/despesa_helper.dart';
import '../domain/despesas.dart';

class SubtiposDespesas extends StatefulWidget {
  final String tipoDespesa;
  const SubtiposDespesas({super.key, required this.tipoDespesa});

  @override
  State<SubtiposDespesas> createState() => _SubtiposDespesasState();
}

class _SubtiposDespesasState extends State<SubtiposDespesas> {
  DespesaHelper helper = DespesaHelper();
  List<Despesas> despesas = [];
  List<Despesas> subDespesas = [];
  void initState() {
    super.initState();
    _pegarAllDespesas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF373737),
          title: Text(
        "Despesas com ${subDespesas[0].tipoDesp.toString() ?? "sub despesas"}",
      )),
      backgroundColor: const Color(0xFFF6D656),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20 ),
        itemCount: subDespesas.length,
        itemBuilder: (context, index) {
          return _subDespesa(context, index);
        },
      ),
    );
  }

  Widget _subDespesa(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFFFAEF),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //descrição
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        '${subDespesas[index].descricao ?? ""}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              Column(children: [
                //Data
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Prazo: ',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${subDespesas[index].dataText ?? ""}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                //valor
                Wrap(
                  children: [
                    const Text(
                      'Valor: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${subDespesas[index].valor ?? ""}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent),
                    )
                  ],
                ),
              ]),

              SizedBox(
                width: 5,
              ),
              /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('dd/MM/yyyy').format(despesas.dateText)),
                      ],
                    ),*/
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      despesas[index].status = "true";
                    });
                  },
                  child: const Text(
                    'Pagar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 60)),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  void _pegarAllDespesas() {
    print(widget.tipoDespesa);
    helper.getAllDespesas().then((list) {
      despesas = list;
      for (int i = 0; i < despesas.length; i++) {
        if (widget.tipoDespesa == despesas[i].tipoDesp.toString()) {
          setState(() {
            subDespesas.add(despesas[i]);
          });
        }
      }
    });
  }
}
