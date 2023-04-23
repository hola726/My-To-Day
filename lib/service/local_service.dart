import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:my_to_day/model/data/diary_data.dart';

enum HiveKey {
  diaryData,
}

class LocalService {
  static final LocalService _singleton = LocalService._internal();
  factory LocalService() => _singleton;

  LocalService._internal();

  Future<Box<T>> handleOpenBox<T>(HiveKey key) async {
    return await Hive.openBox<T>(
      describeEnum(
        key,
      ),
    );
  }

  Box<T> handleBox<T>(HiveKey key) {
    return Hive.box<T>(
      describeEnum(
        key,
      ),
    );
  }

  void registerAdapter() {
    Hive.registerAdapter(DiaryDataAdapter());
  }

  Future<void> openBox() async {
    await handleOpenBox<DiaryData>(HiveKey.diaryData);
  }
}
