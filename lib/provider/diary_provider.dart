import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';

class DiaryProvider extends ChangeNotifier {
  DiaryProvider({
    required LocalStorageHelper localStorageHelper,
    required diaryTextFormFocusNode,
    required BuildContext context,
    required TextEditingController textEditingController,
  })  : _localStorageHelper = localStorageHelper,
        _textEditingController = textEditingController,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _context = context {
    getDiaryData();
  }
  final LocalStorageHelper _localStorageHelper;
  final BuildContext _context;
  final FocusNode _diaryTextFormFocusNode;
  final TextEditingController _textEditingController;

  DiaryData? _diaryData;
  bool _isLargeTextForm = false;
  late List<DiaryData> _allDiaryData;
  late List<DiaryData> _reversedData =
      _allDiaryData.reversed.map((data) => data).toList();

  TextEditingController get textEditingController => _textEditingController;
  DiaryData? get diaryData => _diaryData;
  bool get isLargeTextForm => _isLargeTextForm;
  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;
  List<DiaryData> get allDiaryData => _allDiaryData;
  List<DiaryData> get reversedData => _reversedData;
  BuildContext get context => _context;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }

  set isLargeTextForm(bool isLargeTextForm) {
    _isLargeTextForm = isLargeTextForm;
    notifyListeners();
  }

  void getChange() {
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

  void gestureOnTap() {
    FocusScopeNode currentFocus = FocusScope.of(_context);
    if (!currentFocus.hasPrimaryFocus && _isLargeTextForm == false) {
      currentFocus.unfocus();
    }
  }

  void reSizedDiaryTextFormField() {
    isLargeTextForm = !_isLargeTextForm;

    if (_isLargeTextForm == true) {
      _diaryTextFormFocusNode.requestFocus();
    } else {
      _diaryTextFormFocusNode.unfocus();
    }
  }

  Future<void> setDiaryData(String contents) async {
    await _localStorageHelper.setDiaryData(
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
