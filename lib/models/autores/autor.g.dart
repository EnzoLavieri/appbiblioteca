part of 'autor.dart';

class AutorAdapter extends TypeAdapter<Autor> {
  @override
  final int typeId = 1;

  @override
  Autor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Autor(
      nome: fields[0] as String,
      nacionalidade: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Autor obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.nacionalidade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
