import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';

class DiaryProvider extends ChangeNotifier {
  DiaryProvider({
    required LocalStorageHelper localStorageHelper,
    required BuildContext context,
  })  : _localStorageHelper = localStorageHelper,
        _context = context {
    getDiaryData();
  }
  final LocalStorageHelper _localStorageHelper;
  final BuildContext _context;

  DiaryData? _diaryData;
  List<DiaryData>? _allDiaryData;

  DiaryData? get diaryData => _diaryData;
  List<DiaryData>? get allDiaryData => _allDiaryData;
  void Function() get getDiaryData => _getDiaryData;
  void Function() get gestureOnTap => _gestureOnTap;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }

  void _getDiaryData() {
    _allDiaryData = _localStorageHelper.getAllDiaryData();
    notifyListeners();
  }

  void setDiaryData(String contents) {
    _localStorageHelper.setDiaryData(
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

  void _gestureOnTap() {
    FocusScopeNode currentFocus = FocusScope.of(_context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
