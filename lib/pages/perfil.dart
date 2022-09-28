import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/user.dart';

class Perfil extends StatefulWidget {
  final User? user;
  const Perfil({Key? key, this.user}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late User _editedUser;
  void initState() {
    super.initState();
    if (widget.user == null) {
      _editedUser = User();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tela de Perfil',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Color(0xFF373737),
      ),
      backgroundColor: const Color(0xFFFFFAEF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _editedUser.img == null
                              ? const AssetImage("assets/images/perfil.png")
                                  as ImageProvider
                              : FileImage(File(_editedUser.img.toString())),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((file) {
                    if (file == null) return;
                    setState(() {
                      _editedUser.img = file.path;
                    });
                  });
                },
                onLongPress: (){
                  ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((file) {
                        if(file == null) return;
                        setState(() {
                          _editedUser.img = file.path;
                        });
                  });
                },
              )
              /*Row(
                children: [
                  Text(${_editedUser.name == null ? "Nome do Usuário": _editedUser.name.toString()})
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
