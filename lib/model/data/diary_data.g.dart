// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryDataAdapter extends TypeAdapter<DiaryData> {
  @override
  final int typeId = 0;

  @override
  DiaryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryData(
      contents: fields[1] as String,
      time: fields[2] as DateTime,
      cameraImage: fields[3] as String?,
      pickerImages: (fields[4] as List?)?.cast<String>(),
      locate: fields[5] as String?,
      key: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.contents)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.cameraImage)
      ..writeByte(4)
      ..write(obj.pickerImages)
      ..writeByte(5)
      ..write(obj.locate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
