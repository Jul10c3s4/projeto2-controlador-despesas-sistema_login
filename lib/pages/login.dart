import 'package:controlador_despesas/pages/criar%20conta.dart';
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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String get userName => _email.text;
  String get userPassword => _senha.text;

  late AnimationController _iconAnimationController;
  late AnimationController _formAnimationController;
  late Animation<double> _iconAnimation;
  late Animation<double> _formAnimation;

  late ReactionDisposer disposer;
  bool loading = false;
  bool visible = true;
  bool enable = true;
  bool color = false;

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    _formAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1000));

    _formAnimation = Tween(begin: 0.0, end: 1.0).animate(
      _formAnimationController,
    );

    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeInOut);

    _iconAnimation.addListener(() {
      this.setState(() {});
    });
    playAnimation();
  }

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
                                                if (!value!.contains('@')) {
                                                  return "Falta o @gmail.com";
                                                }
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
                                                  return "A senha possui menos de 6 d??gitos";
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
                                            height: 10,
                                          ),
                                          InkWell(
                                            child: Text(
                                              'Criar conta!',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.blue.shade500),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          CriarConta())));
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _formkey.currentState!.validate()
                                                  ? _logar(
                                                      context) /*loginStore.loginPressed*/
                                                  : null;
                                            },
                                            child: loading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : const Text(
                                                    "Entrar",
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

  void _logar(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: userPassword);

      User? user = userCredential.user;

      if (user != null) {
        _email.text = "";
        _senha.text = "";
        FirebaseAuthAppNavigator.goToHome(context);
      }
      print("signed in: ${user!.uid}");
    } catch (e) {
      print("Error: ${e.toString()}");
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: Text(
                "Erro",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("Email ou senha incorretos!"),
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

  Future playAnimation() async {
    try {
      await _iconAnimationController.forward().orCancel;
      await _formAnimationController.forward().orCancel;
    } on TickerCanceled {
      // anima????o cancelada
    } catch (e) {
      print(e.toString());
    }
  }

  bool get isFormValid => userName.contains("@") && userPassword.length >= 6;
  bool get isEmailValid => userName.contains("@");
  bool get isSenhaValid => userPassword.length >= 6;

  Widget? dialog(String? titulo, String? subtitulo) {
    AlertDialog(
      title: Text(
        "$titulo",
      ),
      content: Text("$subtitulo"),
    );
  }
}
