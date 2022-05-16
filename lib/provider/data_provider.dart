import 'package:flutter/widgets.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';

class DataProvider extends ChangeNotifier {
  DataProvider({
    required LocalStorageHelper localStorageHelper,
  }) : _localStorageHelper = localStorageHelper {
    getDiaryData();
  }

  final LocalStorageHelper _localStorageHelper;
  late List<DiaryData> _allDiaryData;
  DiaryData? _diaryData;
  late List<DiaryData> _reversedData =
      _allDiaryData.reversed.map((data) => data).toList();

  DiaryData? get diaryData => _diaryData;
  List<DiaryData> get allDiaryData => _allDiaryData;
  List<DiaryData> get reversedData => _reversedData;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }

  set allDiaryData(List<DiaryData> allDiaryData) {
    _allDiaryData = allDiaryData;
    notifyListeners();
  }

  void getDiaryData() {
    _allDiaryData = _localStorageHelper.getAllDiaryData();
    getReversedData();
    notifyListeners();
  }

  void getReversedData() {
    _reversedData = _allDiaryData.reversed.map((data) => data).toList();
  }
}
