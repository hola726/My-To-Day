import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:share_plus/share_plus.dart';

class DiaryProvider extends ChangeNotifier {
  DiaryProvider({
    required LocalStorageHelper localStorageHelper,
    required diaryTextFormFocusNode,
    required BuildContext context,
    required TextEditingController diaryTextFormController,
    required TextEditingController searchTextFormController,
  })  : _localStorageHelper = localStorageHelper,
        _diaryTextFormController = diaryTextFormController,
        _searchTextFormController = searchTextFormController,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _context = context;
  final LocalStorageHelper _localStorageHelper;
  final BuildContext _context;
  final FocusNode _diaryTextFormFocusNode;
  final TextEditingController _diaryTextFormController;
  final TextEditingController _searchTextFormController;

  bool _isLargeTextForm = false;
  bool _isSearchState = false;

  TextEditingController get diaryTextFormController => _diaryTextFormController;
  TextEditingController get searchTextFormController =>
      _searchTextFormController;
  bool get isLargeTextForm => _isLargeTextForm;
  bool get isSearchState => _isSearchState;
  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;
  BuildContext get context => _context;

  set isLargeTextForm(bool isLargeTextForm) {
    _isLargeTextForm = isLargeTextForm;
    notifyListeners();
  }

  set isSearchState(bool isSearchState) {
    _isSearchState = isSearchState;
    notifyListeners();
  }

  void getChange() {
    notifyListeners();
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
    DateTime time = DateTime.now();
    await _localStorageHelper.setDiaryData(
      date: time.toString(),
      diaryDataModel: DiaryData(
        contents: contents,
        time: time,
      ),
    );
  }

  Future<void> editDiaryData({
    required String contents,
    required DateTime date,
  }) async {
    await _localStorageHelper.setDiaryData(
      date: date.toString(),
      diaryDataModel: DiaryData(
        contents: contents,
        time: date,
      ),
    );
  }

  bool isSameDay(DiaryData data, DiaryData? previousData) {
    return data.time.year == previousData?.time.year &&
        data.time.month == previousData?.time.month &&
        data.time.day == previousData?.time.day;
  }

  void onShareButtonPressed(String data) {
    Share.share(
      data,
      subject: data,
    );
  }

  void handleDiaryTextFormChanged(String value) {
    diaryTextFormController.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    notifyListeners();
  }

  void handleSearchTextFormChanged(String value) {
    searchTextFormController.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    notifyListeners();
  }
}
