import 'package:hive/hive.dart';
import '../autores/autor.dart';

part 'livro.g.dart';

@HiveType(typeId: 0)
class Livro extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String descricao;

  @HiveField(2)
  double nota;

  @HiveField(3)
  bool favorito;

  @HiveField(4)
  Autor? autor;

  Livro({
    required this.nome,
    required this.descricao,
    required this.nota,
    this.favorito = false,
    this.autor,
  });
}
