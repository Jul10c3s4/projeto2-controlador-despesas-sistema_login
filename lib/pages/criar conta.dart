import 'package:controlador_despesas/pages/destaque_page.dart';
import 'package:controlador_despesas/util/firebase_auth_app_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../widgets/customIconButton.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> with TickerProviderStateMixin {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String get userName => _email.text;
  String get userPassword => _senha.text;

  late ReactionDisposer disposer;
  bool loading = false;
  bool visible = true;
  bool enable = true;
  bool color = false;

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF3D16A),
      body: ListView(
        children: [
          Column(children: [
            Row(
              children: [
                IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            }),
              ],
            ),
            
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 90),
                          child: Card(
                            color: Colors.white,
                            elevation: 16,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  "Criar Conta",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: TextFormField(
                                              validator: (value) {
                                                if (!value!.contains('@gmail.com')) {
                                                  return "Falta o @gmail.com";
                                                }
                                              },
                                              onChanged: (value) {
                                                isFormValid
                                                    ? color = true
                                                    : color = false;
                                              },
                                              controller: _email,
                                              //onChanged: (value) => ,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.person,
                                                    color: Colors.black,
                                                  ),
                                                  label: Text(
                                                    "Email:",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  hintText: "joao@gmail.com",
                                                  hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black45,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )),
                                              enabled: enable,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value!.length <= 6) {
                                                  return "A senha possui menos de 6 dígitos";
                                                }
                                                return null;
                                              },
                                              controller: _senha,
                                              obscureText: visible,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  label: Text(
                                                    "Senha:",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  suffixIcon: CustonIconbutton(
                                                      radius: 32,
                                                      icoData: visible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      onTap: () {
                                                        setState(() {
                                                          visible = !visible;
                                                        });
                                                      }),
                                                  prefixIcon: Icon(
                                                    Icons.https_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  hintText: "*********",
                                                  hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black45,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )),
                                              enabled: enable,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _formkey.currentState!.validate()
                                                  ? registrar(
                                                      context) /*loginStore.loginPressed*/
                                                  : showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            "Erro",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          content: Text(
                                                              "insira os dados corretamente como solicitados"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "ok",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blue),
                                                            )
                                                          ],
                                                        );
                                                      }));
                                            },
                                            child: loading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : const Text(
                                                    "Criar",
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(33),
                                                ),
                                                backgroundColor:
                                                    Colors.deepOrange,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10)),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ])),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ])
        ],
      ),
    ));
  }

  void registrar(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userName, password: userPassword);
      User? user = userCredential.user;

      if (user != null) {
        _email.text = "";
        _senha.text = "";
        FirebaseAuthAppNavigator.goToLogin(context);
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: Text(
                "Erro",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("Falha ao criar registro!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                )
              ],
            );
          }));
    }
  }

  bool get isFormValid => userName.contains("@") && userPassword.length >= 6;
  bool get isEmailValid => userName.contains("@");
  bool get isSenhaValid => userPassword.length >= 6;
}
