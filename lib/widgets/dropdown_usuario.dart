import 'package:flutter/material.dart';
import 'package:todo_app/models/usuario.dart';

class DropdownUsuario extends StatelessWidget {
  final List<Usuario> usuarios;
  final Usuario? usuarioSelecionado;
  final ValueChanged<Usuario?> onChanged;

  const DropdownUsuario({
    required this.usuarios,
    required this.usuarioSelecionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Usuario>(
      value: usuarioSelecionado,
      onChanged: onChanged,
      hint: Text('Selecione o Usuário'),
      items: usuarios.map((usuario) {
        return DropdownMenuItem<Usuario>(
          value: usuario,
          child: Text(usuario.nome),
        );
      }).toList(),
    );
  }
}
