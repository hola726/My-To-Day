class DiaryDataModel {
  final String contents;
  final DateTime time;
  final dynamic image;
  final String? locate;

  const DiaryDataModel({
    required this.contents,
    required this.time,
    this.image,
    this.locate,
  });

  DiaryDataModel copyWith({
    String? contents,
    DateTime? time,
    dynamic image,
    String? locate,
  }) {
    return DiaryDataModel(
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

  factory DiaryDataModel.fromJson(Map<String, dynamic> map) {
    return DiaryDataModel(
      contents: map['contents'] as String,
      time: map['time'] as DateTime,
      image: map['image'] as dynamic,
      locate: map['locate'] as String,
    );
  }
}
