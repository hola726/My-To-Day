import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';

import '../../../model/data/diary_data.dart';
import '../../../provider/data_provider.dart';
import '../../calendar/page/calendar_page.dart';

class DiaryPageModel extends ChangeNotifier {
  DiaryPageModel({
    required BuildContext context,
    required DataProvider dataProvider,
    required FocusNode diaryTextFormFocusNode,
    required DiaryLocalService diaryLocalService,
    required TextEditingController diaryTextFormController,
    required TextEditingController searchTextFormController,
  })  : _context = context,
        _dataProvider = dataProvider,
        _diaryLocalService = diaryLocalService,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _diaryTextFormController = diaryTextFormController,
        _searchTextFormController = searchTextFormController;

  final BuildContext _context;
  final DataProvider _dataProvider;
  final FocusNode _diaryTextFormFocusNode;
  final DiaryLocalService _diaryLocalService;
  final TextEditingController _diaryTextFormController;
  final TextEditingController _searchTextFormController;

  bool _isLargeTextForm = false;
  bool _isSearchState = false;

  BuildContext get context => _context;
  DataProvider get dataProvider => _dataProvider;
  bool get isSearchState => _isSearchState;
  bool get isLargeTextForm => _isLargeTextForm;
  TextEditingController get searchTextFormController =>
      _searchTextFormController;
  TextEditingController get diaryTextFormController => _diaryTextFormController;
  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;

  set isLargeTextForm(bool isLargeTextForm) {
    _isLargeTextForm = isLargeTextForm;
    notifyListeners();
  }

  set isSearchState(bool isSearchState) {
    _isSearchState = isSearchState;
    notifyListeners();
  }

  Future<void> editDiaryData({
    required String contents,
    required DateTime date,
    String? cameraImage,
    List<String>? pickerImage,
    String? locate,
  }) async {
    await _diaryLocalService.editDiaryData(
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

  void onEditPressed() async {
    await editDiaryData(
      contents: _diaryTextFormController.text,
      date: _dataProvider.diaryData!.time,
      cameraImage: _dataProvider.diaryData?.cameraImage,
      pickerImage: _dataProvider.diaryData?.pickerImages,
      locate: _dataProvider.diaryData?.locate,
    );
    _dataProvider.getAllDiaryData();
    _diaryTextFormController.clear();
    Navigator.of(_context).pop();
  }

  double handleDiaryTextFormFieldHeight() {
    if (!isLargeTextForm) return 100.h;

    return MediaQuery.of(_context).size.height -
        MediaQuery.of(_context).viewInsets.bottom -
        _dataProvider.handleFillImageHeight();
  }

  Future<void> setDiaryData({
    required String contents,
    String? cameraImage,
    List<String>? pickerImage,
    String? locate,
  }) async {
    DateTime time = DateTime.now();
    await _diaryLocalService.setDiaryData(
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

  void onCheckBoxIconPressed() async {
    if (_diaryTextFormController.text == "") return;
    await setDiaryData(
      contents: _diaryTextFormController.text,
      cameraImage: _dataProvider.tmpDiaryData?.cameraImage,
      pickerImage: _dataProvider.tmpDiaryData?.pickerImages,
      locate: _dataProvider.tmpDiaryData?.locate,
    );
    _dataProvider.tmpDiaryData = null;
    _dataProvider.getAllDiaryData();
    _diaryTextFormController.clear();
    notifyListeners();
  }

  void handleSearchTextFormChanged(String value) {
    _searchTextFormController.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    notifyListeners();
  }

  void handleDiaryTextFormChanged(String value) {
    _diaryTextFormController.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    notifyListeners();
  }

  void reSizedDiaryTextFormField() {
    isLargeTextForm = !_isLargeTextForm;

    if (_isLargeTextForm == true) {
      _diaryTextFormFocusNode.requestFocus();
    } else {
      _diaryTextFormFocusNode.unfocus();
    }
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

  void onCalendarPressed() {
    context.go(CalendarPage.id);
  }
}
