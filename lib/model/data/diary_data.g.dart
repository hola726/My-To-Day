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
      contents: fields[0] as String,
      time: fields[1] as DateTime,
      cameraImage: fields[2] as String?,
      pickerImages: (fields[3] as List?)?.cast<String>(),
      locate: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.contents)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.cameraImage)
      ..writeByte(3)
      ..write(obj.pickerImages)
      ..writeByte(4)
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
