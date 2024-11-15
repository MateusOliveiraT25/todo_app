import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/tarefa.dart';
import 'package:todo_app/models/usuario.dart';
import 'editar_tarefa.dart'; // Tela para editar a tarefa
import 'cadastro_de_tarefa.dart'; 

class GerenciamentoTarefasScreen extends StatefulWidget {
  @override
  _GerenciamentoTarefasScreenState createState() =>
      _GerenciamentoTarefasScreenState();
}

class _GerenciamentoTarefasScreenState extends State<GerenciamentoTarefasScreen> {
  late List<Tarefa> _tarefasAFAzer;
  late List<Tarefa> _tarefasFazendo;
  late List<Tarefa> _tarefasPronto;

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  // Função que carrega as tarefas de acordo com o seu status
  _carregarTarefas() async {
    var tarefas = await DatabaseHelper.instance.obterTarefas(); // Buscar todas as tarefas
    setState(() {
      _tarefasAFAzer = tarefas.where((t) => t.status == 'a fazer').toList();
      _tarefasFazendo = tarefas.where((t) => t.status == 'fazendo').toList();
      _tarefasPronto = tarefas.where((t) => t.status == 'pronto').toList();
    });
  }

  // Função para excluir tarefa
  _excluirTarefa(String tarefaId) async {
    bool? confirmacao = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação de Exclusão'),
          content: Text('Tem certeza que deseja excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Não excluir
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Confirmar exclusão
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (confirmacao != null && confirmacao) {
      await DatabaseHelper.instance.deletarTarefa(tarefaId);
      _carregarTarefas(); // Atualiza a lista após exclusão
    }
  }

  // Função para atualizar o status da tarefa
  _atualizarStatusTarefa(Tarefa tarefa, String novoStatus) async {
    // Cria uma nova tarefa com o novo status
    Tarefa tarefaAtualizada = tarefa.comNovoStatus(novoStatus);

    // Atualiza a tarefa no banco de dados
    await DatabaseHelper.instance.atualizarTarefa(tarefaAtualizada);
    
    // Recarrega as tarefas para refletir a mudança
    _carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciamento de Tarefas')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildColumn('A Fazer', _tarefasAFAzer),
              _buildColumn('Fazendo', _tarefasFazendo),
              _buildColumn('Pronto', _tarefasPronto),
            ],
          ),
        ),
      ),
    );
  }

  // Função que constrói uma coluna para um status específico
  Widget _buildColumn(String status, List<Tarefa> tarefas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(status, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 250, // Define o tamanho da coluna
          child: ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              Tarefa tarefa = tarefas[index];
              return Card(
                margin: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(tarefa.descricao),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Setor: ${tarefa.setor}'),
                      Text('Prioridade: ${tarefa.prioridade}'),
                      Text('Usuário: ${tarefa.idUsuario}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botão de edição
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CadastroTarefaScreen(
                                tarefa: tarefa,
                              ),
                            ),
                          );
                        },
                      ),
                      // Botão de exclusão
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _excluirTarefa(tarefa.id);
                        },
                      ),
                      // Se o status não for 'pronto', atualiza o status
                      if (tarefa.status != 'pronto')
                        DropdownButton<String>(
                          value: tarefa.status,
                          items: ['a fazer', 'fazendo', 'pronto']
                              .map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (String? novoStatus) {
                            if (novoStatus != null) {
                              _atualizarStatusTarefa(tarefa, novoStatus);
                            }
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
