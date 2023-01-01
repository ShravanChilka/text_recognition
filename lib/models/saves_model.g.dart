// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saves_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavesModelAdapter extends TypeAdapter<SavesModel> {
  @override
  final int typeId = 1;

  @override
  SavesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavesModel(
      recogniseText: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavesModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.recogniseText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
