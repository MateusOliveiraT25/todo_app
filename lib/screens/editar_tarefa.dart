import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/tarefa.dart';

class EditarTarefaScreen extends StatefulWidget {
  final Tarefa tarefa;

  EditarTarefaScreen({required this.tarefa});

  @override
  _EditarTarefaScreenState createState() => _EditarTarefaScreenState();
}

class _EditarTarefaScreenState extends State<EditarTarefaScreen> {
  late TextEditingController _descricaoController;
  late String _prioridade;
  late String _status;

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController(text: widget.tarefa.descricao);
    _prioridade = widget.tarefa.prioridade;
    _status = widget.tarefa.status;
  }

  _atualizarTarefa() async {
    final tarefaAtualizada = Tarefa(
      id: widget.tarefa.id,
      idUsuario: widget.tarefa.idUsuario,
      descricao: _descricaoController.text,
      setor: widget.tarefa.setor,
      prioridade: _prioridade,
      status: _status,
      dataCadastro: widget.tarefa.dataCadastro,
    );
    await DatabaseHelper.instance.atualizarTarefa(tarefaAtualizada);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tarefa atualizada com sucesso!')),
    );
    Navigator.pop(context); // Volta para a tela de lista de tarefas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            DropdownButton<String>(
              value: _prioridade,
              onChanged: (String? newValue) {
                setState(() {
                  _prioridade = newValue!;
                });
              },
              items: ['baixa', 'média', 'alta']
                  .map((prioridade) => DropdownMenuItem<String>(
                        value: prioridade,
                        child: Text(prioridade),
                      ))
                  .toList(),
            ),
            DropdownButton<String>(
              value: _status,
              onChanged: (String? newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
              items: ['a fazer', 'fazendo', 'pronto']
                  .map((status) => DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _atualizarTarefa,
              child: Text('Atualizar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
