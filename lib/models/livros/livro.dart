class Livro {
  final String id;
  final String titulo;
  final String descricao;
  final double nota;
  final int autorId;
  bool isFavorito;

  Livro({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.nota,
    required this.autorId,
    this.isFavorito = false,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      nota: json['nota'],
      autorId: json['autorId'],
      isFavorito: json['isFavorito'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'nota': nota,
      'autorId': autorId,
      'isFavorito': isFavorito,
    };
  }
}
