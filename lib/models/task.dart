class Task {
  final String id;
  final String name;
  final bool completed;

  Task({required this.id, required this.name, this.completed = false});

  // Converte o Task para um formato adequado para o Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completed': completed,
    };
  }

  // Converte um documento do Firestore para um Task
  factory Task.fromDocument(Map<String, dynamic> doc, String id) {
    return Task(
      id: id,
      name: doc['name'],
      completed: doc['completed'] ?? false,
    );
  }
}
