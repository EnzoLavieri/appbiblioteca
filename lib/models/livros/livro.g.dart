part of 'livro.dart';

class LivroAdapter extends TypeAdapter<Livro> {
  @override
  final int typeId = 0;

  @override
  Livro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Livro(
      nome: fields[0] as String,
      descricao: fields[1] as String,
      nota: fields[2] as double,
      favorito: fields[3] as bool,
      autor: fields[4],
    );
  }

  @override
  void write(BinaryWriter writer, Livro obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.nota)
      ..writeByte(3)
      ..write(obj.favorito);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LivroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
