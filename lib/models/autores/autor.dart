class Autor {
  final String id;
  final String nome;
  final String nacionalidade;

  Autor({required this.id, required this.nome, required this.nacionalidade});

  factory Autor.fromJson(Map<String, dynamic> json) {
    return Autor(
      id: json['id'],
      nome: json['nome'],
      nacionalidade: json['nacionalidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'nacionalidade': nacionalidade,
    };
  }
}
