import 'package:hive/hive.dart';

part 'diary_data.g.dart';

@HiveType(typeId: 0)
class DiaryData extends HiveObject {
  DiaryData({
    required this.contents,
    required this.time,
    this.image,
    this.locate,
  });
  @HiveField(0)
  final String contents;
  @HiveField(1)
  final DateTime time;
  @HiveField(2)
  final dynamic image;
  @HiveField(3)
  final String? locate;

  DiaryData copyWith({
    String? contents,
    DateTime? time,
    dynamic image,
    String? locate,
  }) {
    return DiaryData(
      contents: contents ?? this.contents,
      time: time ?? this.time,
      image: image ?? this.image,
      locate: locate ?? this.locate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contents': contents,
      'time': time,
      'image': image,
      'locate': locate,
    };
  }

  factory DiaryData.fromJson(Map<String, dynamic> map) {
    return DiaryData(
      contents: map['contents'] as String,
      time: map['time'] as DateTime,
      image: map['image'] as dynamic,
      locate: map['locate'] as String,
    );
  }
}