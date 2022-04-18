// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryDataModelAdapter extends TypeAdapter<DiaryDataModel> {
  @override
  final int typeId = 0;

  @override
  DiaryDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryDataModel(
      contents: fields[0] as String,
      time: fields[1] as DateTime,
      image: fields[2] as dynamic,
      locate: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.contents)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.locate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
