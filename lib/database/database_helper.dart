import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/usuario.dart';
import '../models/tarefa.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Método para inicializar o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Função que cria o banco de dados
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo_app.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Função que cria as tabelas no banco de dados
  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE usuarios(
        id TEXT PRIMARY KEY,
        nome TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    await db.execute(''' 
      CREATE TABLE tarefas(
        id TEXT PRIMARY KEY,
        descricao TEXT NOT NULL,
        setor TEXT NOT NULL,
        prioridade TEXT NOT NULL,
        status TEXT NOT NULL,
        dataCadastro TEXT NOT NULL,
        idUsuario TEXT,
        FOREIGN KEY(idUsuario) REFERENCES usuarios(id) ON DELETE CASCADE
      )
    ''');
  }

  // Função para inserir um usuário no banco de dados
  Future<void> inserirUsuario(Usuario usuario) async {
    final db = await database;
    await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para obter todos os usuários
  Future<List<Usuario>> obterUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  // Função para inserir uma tarefa no banco de dados
  Future<void> inserirTarefa(Tarefa tarefa) async {
    final db = await database;
    await db.insert(
      'tarefas',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para obter todas as tarefas
  Future<List<Tarefa>> obterTarefas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tarefas');
    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  }

  // Função para obter tarefas por status (por exemplo, 'a fazer', 'fazendo', 'pronto')
  Future<List<Tarefa>> obterTarefasPorStatus(String status) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tarefas',
      where: 'status = ?',
      whereArgs: [status],
    );
    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  }

  // Função para atualizar uma tarefa existente
  Future<void> atualizarTarefa(Tarefa tarefa) async {
    final db = await database;
    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  // Função para deletar uma tarefa pelo ID
  Future<void> deletarTarefa(String id) async {
    final db = await database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
