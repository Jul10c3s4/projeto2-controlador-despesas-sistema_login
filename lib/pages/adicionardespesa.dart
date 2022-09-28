import 'package:flutter/material.dart';
import 'package:controlador_despesas/domain/despesas.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AddDespesa extends StatefulWidget {
  final Despesas? despesa;
  const AddDespesa({Key? key, this.despesa}) : super(key: key);

  @override
  State<AddDespesa> createState() => _AddDespesaState();
}

class _AddDespesaState extends State<AddDespesa> {
  final _dropValue = ValueNotifier('');

  final dropOpcoes = ['Casa', 'Saúde', 'Educação', "Trabalho", "Diversão"];
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();

  final _descriptionFocus = FocusNode();

  //Essa variável serve para verificar se a despesa já existe no banco, caso já exista
  //o usuário poderá modifcar os dados
  bool _userEdited = false;

  late Despesas _editedDespesas;

  DateTime? _now;

  void initState() {
    super.initState();

    if (widget.despesa == null) {
      _editedDespesas = Despesas();
    } else {
      _editedDespesas = Despesas.fromMap(widget.despesa!.toMap());
      _descricaoController.text = _editedDespesas.descricao!;
      _valorController.text = _editedDespesas.valor!.toString();
      _dropValue.value = _editedDespesas.tipoDesp!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              /*_editedDespesas.descricao ??*/ "Nova Despesa",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            backgroundColor: Color(0xFF373737),
            centerTitle: true,
          ),
          backgroundColor: Color(0xFFF3D16A),
          body: Padding(
            padding: EdgeInsets.symmetric( horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Descrição da Despesa: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFFFFFAEF)),
                    child: TextField(
                      controller: _descricaoController,
                      onChanged: (text) {
                        _userEdited = true;
                        _editedDespesas.descricao = text;
                      },
                      //serve para focar o textfield ao abrir a tela
                      focusNode: _descriptionFocus,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Conta de luz',
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tipo de Despesa: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: _dropValue,
                        builder: (BuildContext context, String value, _) {
                          return SizedBox(
                            width: 120,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              //para mudar o icone
                              //icon: const Icon(Icons.),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hint: Text(
                                'casa',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) {
                                _dropValue.value = escolha.toString();
                                print(value);
                                _userEdited = true;
                                _editedDespesas.tipoDesp = _dropValue.value;
                              },
                              items: dropOpcoes
                                  .map(
                                    (opcao) => DropdownMenuItem(
                                      value: opcao,
                                      child: Text(opcao),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        })
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Valor:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFFFFFAEF)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _valorController,
                      onChanged: (text) {
                        _userEdited = true;
                        _editedDespesas.valor =
                            double.parse(_valorController.text ?? "0");
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '100',
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Row(children: [
                  Text(
                    "Prazo da despesa: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white24,
                      ),
                      child: Center(
                        child: Text(
                          '${_editedDespesas.dataText ?? "Data"}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () async {
                          /*(text) {
                        _userEdited = true;
                        _editedDespesas.valor =
                            int.parse(_valorController.text ?? "0");
                      }, */
                          _now = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2024),
                            locale: Locale("pt", "BR"),
                          );
                          setState(() {
                            _userEdited = true;
                            print(_now);
                            //'${DateFormat('dd/MM/yyyy').format(_editedDespesas.dataText ?? DateTime.now())}',
                            _editedDespesas.data = DateFormat('dd/MM/yyyy')
                                .format(_now!) as String;
                          });
                        },
                        icon: Icon(Icons.date_range)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    salvarDespesa();
                  },
                  child: Text(
                    'Adicionar Despesa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    padding: EdgeInsets.symmetric(vertical: 15,),
                  ),
                )
              ],
            )),
          ),
        ),
        onWillPop: _quandosair);
  }

  Future<bool> _quandosair() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar alterações ?'),
              content: const Text(
                  'Se você sair as alterações feitas serão perdidas!'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue),
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void salvarDespesa() {
    if (_editedDespesas.descricao != null &&
        _editedDespesas.descricao!.isNotEmpty) {
      Navigator.pop(context, _editedDespesas);
    } else {
      FocusScope.of(context).requestFocus(_descriptionFocus);
    }
  }
}
