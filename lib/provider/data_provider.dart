import 'package:flutter/cupertino.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';

class DiaryProvider extends ChangeNotifier {
  DiaryProvider({
    required this.localStorageHelper,
  }) {
    getDiaryData();
  }
  final LocalStorageHelper localStorageHelper;

  DiaryData? _diaryData;
  List<DiaryData>? _allDiaryData;

  DiaryData? get diaryData => _diaryData;
  List<DiaryData>? get allDiaryData => _allDiaryData;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }

  void getDiaryData() {
    _allDiaryData = localStorageHelper.getAllDiaryData();
    notifyListeners();
  }

  void setDiaryData(String contents) {
    localStorageHelper.setDiaryData(
      date: DateTime.now().toString(),
      diaryDataModel: DiaryData(
        contents: contents,
        time: DateTime.now(),
      ),
    );
  }

  bool isSameDay(DiaryData data, DiaryData? previousData) {
    return data.time.year == previousData?.time.year &&
        data.time.month == previousData?.time.month &&
        data.time.day == previousData?.time.day;
  }
}
