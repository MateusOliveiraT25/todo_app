import 'package:flutter/material.dart';
import '../models/usuario.dart';
import 'cadastrar_usuario.dart'; // Importe a tela de cadastro de usuário

class HomeScreen extends StatefulWidget {
  final Usuario usuario;

  HomeScreen({required this.usuario});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas de ${widget.usuario.nome}'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Navega para a tela de cadastro de usuário
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastrarUsuarioScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('Tela principal de tarefas'),
      ),
    );
  }
}
