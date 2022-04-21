import 'package:flutter/cupertino.dart';
import 'package:my_to_day/model/data/diary_data.dart';

class DataProvider extends ChangeNotifier {
  DiaryData? _diaryData;

  DiaryData? get diaryData => _diaryData;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }
}
