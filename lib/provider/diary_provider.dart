import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:share_plus/share_plus.dart';

class DiaryProvider extends ChangeNotifier {
  DiaryProvider({
    required BuildContext context,
    required diaryTextFormFocusNode,
    required DataProvider dataProvider,
    required LocalStorageHelper localStorageHelper,
    required TextEditingController diaryTextFormController,
    required TextEditingController searchTextFormController,
  })  : _context = context,
        _dataProvider = dataProvider,
        _localStorageHelper = localStorageHelper,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _diaryTextFormController = diaryTextFormController,
        _searchTextFormController = searchTextFormController;

  final BuildContext _context;
  final DataProvider _dataProvider;
  final FocusNode _diaryTextFormFocusNode;
  final LocalStorageHelper _localStorageHelper;
  final TextEditingController _diaryTextFormController;
  final TextEditingController _searchTextFormController;

  bool _isLargeTextForm = false;
  bool _isSearchState = false;

  BuildContext get context => _context;
  bool get isSearchState => _isSearchState;
  bool get isLargeTextForm => _isLargeTextForm;
  DataProvider get dataProvider => _dataProvider;
  TextEditingController get searchTextFormController =>
      _searchTextFormController;
  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;
  TextEditingController get diaryTextFormController => _diaryTextFormController;

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

  Future<void> setDiaryData({
    required String contents,
    String? cameraImage,
    List<String>? pickerImage,
    String? locate,
  }) async {
    DateTime time = DateTime.now();
    await _localStorageHelper.setDiaryData(
      key: time.toString(),
      diaryDataModel: DiaryData(
        contents: contents,
        time: time,
        cameraImage: cameraImage,
        pickerImages: pickerImage,
        locate: locate,
      ),
    );
  }

  Future<void> editDiaryData({
    required String contents,
    required DateTime date,
    String? cameraImage,
    List<String>? pickerImage,
    String? locate,
  }) async {
    await _localStorageHelper.editDiaryData(
      key: date.toString(),
      diaryDataModel: DiaryData(
        contents: contents,
        time: date,
        cameraImage: cameraImage,
        pickerImages: pickerImage,
        locate: locate,
      ),
    );
  }

  bool isSameDay(DiaryData data, DiaryData? previousData) {
    return data.time.year == previousData?.time.year &&
        data.time.month == previousData?.time.month &&
        data.time.day == previousData?.time.day;
  }

  void onShareButtonPressed(String data) {
    if (_dataProvider.diaryData?.pickerImages == null &&
        _dataProvider.diaryData?.cameraImage == null) {
      Share.share(
        data,
        subject: data,
      );
      return;
    }
    List<String> images = [];
    if (_dataProvider.diaryData?.cameraImage != null) {
      images.add(_dataProvider.diaryData!.cameraImage!);
    }
    if (_dataProvider.diaryData?.pickerImages != null) {
      images.addAll(_dataProvider.diaryData!.pickerImages!);
    }

    Share.shareFiles(
      images,
      text: data,
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

  int handleSwipeItemCount() {
    if (_dataProvider.diaryData?.cameraImage != null &&
        _dataProvider.diaryData?.pickerImages != null) {
      return _dataProvider.diaryData!.pickerImages!.length + 1;
    }
    if (_dataProvider.diaryData?.cameraImage != null) {
      return 1;
    }

    return _dataProvider.diaryData!.pickerImages!.length;
  }

  Widget handleSwipeItemBuilder(BuildContext context, int index) {
    bool isExistCameraImage = _dataProvider.diaryData?.cameraImage != null;
    if (isExistCameraImage && index == 0) {
      return Image.file(
        File(
          _dataProvider.diaryData!.cameraImage!,
        ),
      );
    }
    return Image.file(
      File(
        _dataProvider
            .diaryData!.pickerImages![index - (isExistCameraImage ? 1 : 0)],
      ),
    );
  }
}
