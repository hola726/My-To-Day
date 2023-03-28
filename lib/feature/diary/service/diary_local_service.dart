import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/service/local_service.dart';

class DiaryLocalService {
  DiaryLocalService({required LocalService localService})
      : _localService = localService;

  final LocalService _localService;

  DiaryData? getDiaryData({required date}) {
    return _localService.handleBox<DiaryData>(HiveKey.diaryData).get(date);
  }

  List<DiaryData> getAllDiaryData() {
    return _localService
        .handleBox<DiaryData>(HiveKey.diaryData)
        .values
        .map((data) => data)
        .toList();
  }

  Future<void> setDiaryData({
    required String key,
    required DiaryData diaryDataModel,
  }) async {
    await _localService
        .handleBox<DiaryData>(HiveKey.diaryData)
        .put(key, diaryDataModel);
  }

  Future<void> editDiaryData({
    required String key,
    required DiaryData diaryDataModel,
  }) async {
    await deleteDiaryData(key: key);
    await setDiaryData(key: key, diaryDataModel: diaryDataModel);
  }

  Future<void> deleteDiaryData({required key}) async {
    await _localService.handleBox<DiaryData>(HiveKey.diaryData).delete(key);
  }
}
