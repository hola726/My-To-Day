import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:my_to_day/model/data/diary_data_model.dart';

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
    Hive.registerAdapter(DiaryDataModelAdapter());
  }

  Future<void> openBox() async {
    await handleOpenBox<DiaryDataModel>(HiveKey.diaryData);
  }

  DiaryDataModel? getDiaryData({required date}) {
    return handleBox<DiaryDataModel>(HiveKey.diaryData).get(date);
  }

  Future<void> setDiaryData({
    required String date,
    required DiaryDataModel diaryDataModel,
  }) async {
    await handleBox<DiaryDataModel>(HiveKey.diaryData)
        .put(date, diaryDataModel);
  }

  Future<void> deleteDiaryData({required date}) async {
    await handleBox<DiaryDataModel>(HiveKey.diaryData).delete(date);
  }
}
