import 'package:controlador_despesas/domain/despesa_helper.dart';
import 'package:flutter/material.dart';
import 'package:controlador_despesas/domain/despesas.dart';
import 'package:controlador_despesas/pages/homepage.dart';
import 'package:controlador_despesas/pages/perfil.dart';
import 'package:controlador_despesas/widgets/card_despesas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'adicionardespesa.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DespesaHelper helper = DespesaHelper();
  List<Despesas> despesas = [];
  List<Despesas> despPedentes = [];

  void initState() {
    super.initState();
    _getAllDespesas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF373737),
        centerTitle: true,
        title: Text(
          'Despesas',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        actions: [
          //No PopupMenuButton cria-se botões com opções
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                  value: OrderOptions.orderaz, child: Text("Ordenar de A-Z")),
              const PopupMenuItem<OrderOptions>(
                  value: OrderOptions.orderza, child: Text("Ordenar de Z-A"))
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6D656),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageAddDespesa();
        },
        backgroundColor: Color(0xFF373737),
        child: Icon(
          Icons.add,
          size: 20,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        itemCount: despesas.length,
        itemBuilder: (context, index) {
          return _despesaCard(context, index);
        },
      ),
    );
  }

  void _pageAddDespesa({Despesas? despesa}) async {
    final recDespesas = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddDespesa(despesa: despesa)));
    if (recDespesas != null) {
      if (despesa != null) {
        await helper.updateDespesa(recDespesas);
      } else {
        await helper.saveDespesa(recDespesas);
      }
      _getAllDespesas();
    }
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            helper.deletaDespesa(despesas[index].id!.toInt());
                            setState(() {
                              despesas.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            'Excluir Despesa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pageAddDespesa(despesa: despesas[index]);
                          },
                          child: const Text(
                            'Editar Despesa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Widget _despesaCard(BuildContext context, int index) {
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
                            '${despesas[index].descricao ?? ""}',
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
                  //tipo de despesa
                  Column(children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            'Tipo de Despesa:',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${despesas[index].tipoDesp ?? ""}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
                        '${despesas[index].dataText}',
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${despesas[index].valor ?? ""}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
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
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20,),
                  child:  TextButton(
                    onPressed: () {
                      setState(() {
                        despesas.removeAt(index);
                        //helper.updateStatus(despesas[index]);
                      });
                    },
                    child: const Text(
                      'Paguei',
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
                  ),),
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

  void _getAllDespesas() {
    helper.getAllDespesas().then((list) {
      setState(() {
        despesas = list;
        for(int i = 0; i < despesas.length; i++){
          if(despesas[i].status == "true"){
            despPedentes.add(despesas[i]);
          }
        }
      });
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        setState(() {
          despesas.sort((a, b) {
            return a.descricao!
                .toLowerCase()
                .compareTo(b.descricao!.toLowerCase());
          });
        });
        break;
      case OrderOptions.orderza:
        setState(() {
          despesas.sort((a, b) {
            return b.descricao!
                .toLowerCase()
                .compareTo(a.descricao!.toLowerCase());
          });
        });
        break;
    }
  }
}
