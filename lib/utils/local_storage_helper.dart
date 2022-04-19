import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:my_to_day/model/data/diary_data.dart';

enum HiveKey {
  diaryData,
}

class LocalStorageHelper {
  static final LocalStorageHelper _singleton = LocalStorageHelper._internal();
  factory LocalStorageHelper() => _singleton;

  LocalStorageHelper._internal();

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

  DiaryData? getDiaryData({required date}) {
    return handleBox<DiaryData>(HiveKey.diaryData).get(date);
  }

  List<DiaryData> getAllDiaryData() {
    return handleBox<DiaryData>(HiveKey.diaryData)
        .values
        .map((data) => data)
        .toList();
  }

  Future<void> setDiaryData({
    required String date,
    required DiaryData diaryDataModel,
  }) async {
    await handleBox<DiaryData>(HiveKey.diaryData).put(date, diaryDataModel);
  }

  Future<void> deleteDiaryData({required date}) async {
    await handleBox<DiaryData>(HiveKey.diaryData).delete(date);
  }
}
