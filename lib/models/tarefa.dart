class Tarefa {
  final String id;
  final String descricao;
  final String setor;
  final String prioridade;
  String status;  // Agora 'status' não é final para permitir alteração
  final String dataCadastro;
  final String idUsuario;

  Tarefa({
    required this.id,
    required this.descricao,
    required this.setor,
    required this.prioridade,
    required this.status,
    required this.dataCadastro,
    required this.idUsuario,
  });

  // Método para atualizar o status de uma tarefa
  void atualizarStatus(String novoStatus) {
    status = novoStatus;
  }

  // Método para criar uma nova instância com o novo status
  Tarefa comNovoStatus(String novoStatus) {
    return Tarefa(
      id: id,
      descricao: descricao,
      setor: setor,
      prioridade: prioridade,
      status: novoStatus,
      dataCadastro: dataCadastro,
      idUsuario: idUsuario,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'setor': setor,
      'prioridade': prioridade,
      'status': status,
      'dataCadastro': dataCadastro,
      'idUsuario': idUsuario,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      descricao: map['descricao'],
      setor: map['setor'],
      prioridade: map['prioridade'],
      status: map['status'],
      dataCadastro: map['dataCadastro'],
      idUsuario: map['idUsuario'],
    );
  }
}
