
class AvariaNotification {
  final int id;
  final String funcionarioId;
  final int linhaId;
  final String tipo;
  final String prioridade;
  final bool estado;
  final String criacao;


  const AvariaNotification({
    required this.id,
    required this.funcionarioId,
    required this.linhaId,
    required this.tipo,
    required this.prioridade,
    required this.estado,
    required this.criacao,
  });


  static AvariaNotification fromJson(json) => AvariaNotification(
    id: json['id'],
    funcionarioId: json['funcionarioId'],
    linhaId: json['linhaId'],
    tipo: json['tipo'],
    prioridade: json['prioridade'],
    estado: json['estado'],
    criacao: json['criacao'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'funcionarioId': funcionarioId,
    'linhaId': linhaId,
    'tipo': tipo,
    'prioridade': prioridade,
    'estado': estado,
    'criacao': criacao,
  };
}
