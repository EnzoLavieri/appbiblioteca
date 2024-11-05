import 'package:hive/hive.dart';

part 'autor.g.dart';

@HiveType(typeId: 1)
class Autor extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String nacionalidade;

  Autor({required this.nome, required this.nacionalidade});
}
