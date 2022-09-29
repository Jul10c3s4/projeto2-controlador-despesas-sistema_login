import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: TextField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
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
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: TextField(
                                      controller: _senha,
                                      obscureText: true,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          label: Text(
                                            "Senha:",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.remove_red_eye_rounded,
                                              color: Colors.black,
                                            ),
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
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _logar();
                                    },
                                    child: Text(
                                      "Entrar",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                  ),
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
  void _logar(){
    
  }
}
