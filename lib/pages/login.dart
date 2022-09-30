import 'package:controlador_despesas/pages/destaque_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../store/login_store.dart';
import '../widgets/customIconButton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  late LoginStore loginStore;
  late ReactionDisposer disposer;

  void didChangeDependencies() {
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);
    disposer = reaction((_) => loginStore.loggedIn, (loggedIn) {
      if (loginStore.loggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const DestaquePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF3D16A),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
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
                                padding: EdgeInsets.symmetric(horizontal: 20),
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
                                              horizontal: 24, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.orangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            "Login",
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Observer(builder: (_) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: _email,
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
                                                  fontWeight: FontWeight.w500,
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
                                                    BorderRadius.circular(10),
                                              )),
                                          enabled: !loginStore.loading,
                                          onChanged: loginStore.setEmail,
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Observer(builder: (_) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: _senha,
                                          obscureText:
                                              loginStore.passWordVisible,
                                          keyboardType:
                                              TextInputType.text,
                                          decoration: InputDecoration(
                                              label: Text(
                                                "Senha:",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              suffixIcon: CustonIconbutton(
                                                radius: 32,
                                                icoData:
                                                    loginStore.passWordVisible
                                                        ? Icons.visibility 
                                                        : Icons.visibility_off,
                                                onTap: loginStore
                                                    .togllePasswordVisibility,
                                              ),
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
                                                    BorderRadius.circular(10),
                                              )),
                                          enabled: !loginStore.loading,
                                          onChanged: loginStore.setPassword,
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Observer(builder: (_) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          loginStore.isFormValid ||
                                                  loginStore.loading
                                              ? null
                                              : loginStore.loginPressed;
                                        },
                                        child: loginStore.loading
                                            ? const CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white))
                                            : const Text(
                                                "Entrar",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(33),
                                            ),
                                            backgroundColor: loginStore
                                                        .isEmailValid &&
                                                    loginStore.isPasswordValid
                                                ? Colors.deepOrange
                                                : Colors.deepOrange
                                                    .withAlpha(100),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                      );
                                    }),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }

  void dispose() {
    disposer();
    super.dispose();
  }

  void _logar() {}
}
