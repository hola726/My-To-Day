import 'package:hive/hive.dart';

part 'diary_data.g.dart';

@HiveType(typeId: 0)
class DiaryData extends HiveObject {
  DiaryData({
    required this.contents,
    required this.time,
    this.cameraImage,
    this.pickerImages,
    this.locate,
  });
  @HiveField(0)
  final String contents;
  @HiveField(1)
  final DateTime time;
  @HiveField(2)
  final dynamic cameraImage;
  @HiveField(3)
  final dynamic pickerImages;
  @HiveField(4)
  final String? locate;

  DiaryData copyWith({
    String? contents,
    DateTime? time,
    dynamic cameraImage,
    dynamic pickerImages,
    String? locate,
  }) {
    return DiaryData(
      contents: contents ?? this.contents,
      time: time ?? this.time,
      cameraImage: cameraImage ?? this.cameraImage,
      pickerImages: pickerImages ?? this.pickerImages,
      locate: locate ?? this.locate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contents': contents,
      'time': time,
      'image': cameraImage,
      'locate': locate,
    };
  }

  factory DiaryData.fromJson(Map<String, dynamic> map) {
    return DiaryData(
      contents: map['contents'] as String,
      time: map['time'] as DateTime,
      cameraImage: map['image'] as dynamic,
      locate: map['locate'] as String,
    );
  }
}
