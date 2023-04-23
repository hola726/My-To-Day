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
    this.key,
  });

  @HiveField(0)
  final String? key;
  @HiveField(1)
  final String contents;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final String? cameraImage;
  @HiveField(4)
  final List<String>? pickerImages;
  @HiveField(5)
  final String? locate;

  DiaryData copyWith({
    String? key,
    String? contents,
    DateTime? time,
    String? cameraImage,
    List<String>? pickerImages,
    String? locate,
  }) {
    return DiaryData(
      key: key ?? this.key,
      contents: contents ?? this.contents,
      time: time ?? this.time,
      cameraImage: cameraImage ?? this.cameraImage,
      pickerImages: pickerImages ?? this.pickerImages,
      locate: locate ?? this.locate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'contents': contents,
      'time': time,
      'image': cameraImage,
      'locate': locate,
    };
  }

  factory DiaryData.fromJson(Map<String, dynamic> map) {
    return DiaryData(
      key: map['key'] as String,
      contents: map['contents'] as String,
      time: map['time'] as DateTime,
      cameraImage: map['image'] as dynamic,
      locate: map['locate'] as String,
    );
  }
}
