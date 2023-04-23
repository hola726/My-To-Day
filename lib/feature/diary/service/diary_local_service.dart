import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/service/local_service.dart';
import 'package:uuid/uuid.dart';

class DiaryLocalService {
  DiaryLocalService({required LocalService localService})
      : _localService = localService;

  final LocalService _localService;

  List<DiaryData> getAllDiaryData() {
    return _localService
        .handleBox<DiaryData>(HiveKey.diaryData)
        .values
        .toList();
  }

  Future<void> setDiaryData({
    required DiaryData diaryData,
  }) async {
    String key = Uuid().v4();
    DiaryData data = diaryData.copyWith(key: key);

    await _localService.handleBox<DiaryData>(HiveKey.diaryData).put(key, data);
  }

  Future<void> editDiaryData({
    required DiaryData diaryData,
  }) async {
    await deleteDiaryData(key: diaryData.key);
    await setDiaryData(diaryData: diaryData);
  }

  Future<void> deleteDiaryData({required key}) async {
    await _localService.handleBox<DiaryData>(HiveKey.diaryData).delete(key);
  }
}
