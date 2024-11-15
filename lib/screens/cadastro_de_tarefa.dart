import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/tarefa.dart';
import 'package:todo_app/models/usuario.dart';

class CadastroTarefaScreen extends StatefulWidget {
  final Tarefa? tarefa; // Pode ser null se for cadastro de nova tarefa

  // Adicionando parâmetro tarefa para edição
  CadastroTarefaScreen({this.tarefa});

  @override
  _CadastroTarefaScreenState createState() => _CadastroTarefaScreenState();
}

class _CadastroTarefaScreenState extends State<CadastroTarefaScreen> {
  final _descricaoController = TextEditingController();
  String _prioridade = 'baixa';
  String _status = 'a fazer';
  Usuario? _usuarioSelecionado;
  List<Usuario> _usuarios = [];
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  // Função que carrega os usuários cadastrados no banco de dados
  _carregarUsuarios() async {
    var usuarios = await DatabaseHelper.instance.obterUsuarios();
    setState(() {
      _usuarios = usuarios;
    });

    // Se uma tarefa foi passada, configura os campos com os dados da tarefa
    if (widget.tarefa != null) {
      _isEditing = true;
      _descricaoController.text = widget.tarefa!.descricao;
      _prioridade = widget.tarefa!.prioridade;
      _status = widget.tarefa!.status;

      // Garantir que a lista de usuários não está vazia
      if (_usuarios.isNotEmpty) {
        // Caso não encontre um usuário correspondente, atribui o primeiro usuário (ou outro valor default)
        _usuarioSelecionado = _usuarios.firstWhere(
          (usuario) => usuario.id == widget.tarefa!.idUsuario,
          orElse: () {
            // Valor de fallback, no caso de não encontrar o usuário
            return _usuarios[0]; // Retorna o primeiro usuário da lista
          },
        );
      }
    }
  }

  // Função para cadastrar ou editar a tarefa
  _salvarTarefa() async {
    if (_descricaoController.text.isEmpty || _usuarioSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos os campos devem ser preenchidos!')),
      );
      return;
    }

    final novaTarefa = Tarefa(
      id: _isEditing ? widget.tarefa!.id : DateTime.now().toString(),
      idUsuario: _usuarioSelecionado!.id,
      descricao: _descricaoController.text,
      setor: 'Setor Exemplo', // Defina o setor conforme sua necessidade
      prioridade: _prioridade,
      status: _status,
      dataCadastro: _isEditing ? widget.tarefa!.dataCadastro : DateTime.now().toString(),
    );

    if (_isEditing) {
      await DatabaseHelper.instance.atualizarTarefa(novaTarefa);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarefa atualizada com sucesso!')),
      );
    } else {
      await DatabaseHelper.instance.inserirTarefa(novaTarefa);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro concluído com sucesso!')),
      );
    }

    Navigator.pop(context); // Volta para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Tarefa' : 'Cadastrar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição da Tarefa'),
            ),
            SizedBox(height: 10),

            // Dropdown para prioridade
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
              hint: Text('Selecione a Prioridade'),
            ),
            SizedBox(height: 10),

            // Dropdown para status
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
              hint: Text('Selecione o Status'),
            ),
            SizedBox(height: 10),

            // Dropdown para selecionar o usuário
            DropdownButton<Usuario>(
              value: _usuarioSelecionado,
              onChanged: (Usuario? newValue) {
                setState(() {
                  _usuarioSelecionado = newValue;
                });
              },
              hint: Text('Selecione o Usuário'),
              items: _usuarios.map((usuario) {
                return DropdownMenuItem<Usuario>(
                  value: usuario,
                  child: Text(usuario.nome),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Botão para salvar ou editar a tarefa
            ElevatedButton(
              onPressed: _salvarTarefa,
              child: Text(_isEditing ? 'Atualizar Tarefa' : 'Cadastrar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
