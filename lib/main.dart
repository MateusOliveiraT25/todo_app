import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cadastrar_usuario.dart';
import 'models/usuario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CadastrarUsuarioScreen(), // Aqui você pode redirecionar para a tela de cadastro ou login
    );
  }
}
