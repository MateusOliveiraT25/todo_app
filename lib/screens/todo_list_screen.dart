import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Função para criar uma nova tarefa
  Future<void> _addTask(String taskName, BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && taskName.trim().isNotEmpty) {  // Verifica se o nome não é vazio ou só espaços
      try {
        await _tasksCollection.add({
          'userId': userId,
          'name': taskName,
          'completed': false,
          'createdAt': FieldValue.serverTimestamp(), // Registro de data de criação
          'updatedAt': FieldValue.serverTimestamp(), // Registro de data de atualização
        });
        _taskController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tarefa adicionada com sucesso!')),
        );
      } catch (e) {
        print('Erro ao adicionar tarefa: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar tarefa!')),
        );
      }
    } else {
      // Exibir uma mensagem de erro ou aviso se o nome for vazio ou só espaços
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nome da tarefa não pode ser vazio ou apenas espaços!')),
      );
    }
  }

  // Função para atualizar o status de conclusão de uma tarefa
  Future<void> _toggleTaskCompletion(DocumentSnapshot doc) async {
    try {
      await _tasksCollection.doc(doc.id).update({
        'completed': !doc['completed'],
        'updatedAt': FieldValue.serverTimestamp(), // Atualiza data de modificação
      });
    } catch (e) {
      print('Erro ao atualizar tarefa: $e');
      // Tratar erro de forma apropriada
    }
  }

  // Função para atualizar o nome da tarefa
  Future<void> _updateTaskName(DocumentSnapshot doc, String newName, BuildContext context) async {
    if (newName.trim().isNotEmpty) {  // Verifica se o nome não é vazio ou só espaços
      try {
        await _tasksCollection.doc(doc.id).update({
          'name': newName,
          'updatedAt': FieldValue.serverTimestamp(), // Atualiza data de modificação
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tarefa atualizada com sucesso!')),
        );
      } catch (e) {
        print('Erro ao atualizar tarefa: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar tarefa!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nome da tarefa não pode ser vazio ou apenas espaços!')),
      );
    }
  }

  // Função para deletar uma tarefa
  Future<void> _deleteTask(DocumentSnapshot doc, BuildContext context) async {
    try {
      await _tasksCollection.doc(doc.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarefa deletada com sucesso!')),
      );
    } catch (e) {
      print('Erro ao deletar tarefa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar tarefa!')),
      );
    }
  }

  // Mostra um diálogo para editar o nome da tarefa
  void _editTaskName(BuildContext context, DocumentSnapshot doc) {
    final editController = TextEditingController(text: doc['name']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Tarefa', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: editController,
            style: const TextStyle(color: Colors.white), // Cor do texto do input (branco)
            decoration: const InputDecoration(
              labelText: 'Nome da Tarefa',
              labelStyle: TextStyle(color: Colors.white),  // Cor do label (branco)
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),  // Cor da borda (branca)
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                await _updateTaskName(doc, editController.text, context);
                Navigator.pop(context);
              },
              child: const Text('Salvar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Color(0xFF9C4D97), // Cor de fundo mais clara (roxo)
      appBar: AppBar(
        title: const Text('Lista de Tarefas', style: TextStyle(color: Colors.white)), // Cor do título (branco)
        backgroundColor: Color(0xFF9C4D97),  // Cor de fundo da AppBar (roxo claro)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Cor do ícone de voltar (branco)
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // Cor do ícone de logout (branco)
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _taskController,
              style: const TextStyle(color: Colors.white), // Cor do texto do input (branco)
              decoration: InputDecoration(
                labelText: 'Nova Tarefa',
                labelStyle: const TextStyle(color: Colors.white),  // Cor do label (branco)
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white), // Cor do ícone de adicionar (branco)
                  onPressed: () => _addTask(_taskController.text, context),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _tasksCollection.where('userId', isEqualTo: userId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final tasks = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        task['name'],
                        style: TextStyle(
                          decoration: task['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: Colors.white, // Cor do texto da tarefa (branco)
                        ),
                      ),
                      leading: Checkbox(
                        value: task['completed'],
                        onChanged: (_) => _toggleTaskCompletion(task),
                        activeColor: Colors.orange,  // Cor do checkbox (laranja)
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _editTaskName(context, task),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTask(task, context),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
