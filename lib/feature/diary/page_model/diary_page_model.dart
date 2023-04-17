import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/data/diary_data.dart';
import '../../../utils/modal_helper.dart';
import '../../calendar/page/calendar_page.dart';
import '../page/diary_edit_page.dart';

class DiaryPageModel extends ChangeNotifier {
  DiaryPageModel({
    required BuildContext context,
    required FocusNode diaryTextFormFocusNode,
    required DiaryLocalService localService,
    required TextEditingController diaryTextFormController,
    required TextEditingController searchTextFormController,
  })  : _context = context,
        _localService = localService,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _diaryTextFormController = diaryTextFormController,
        _searchTextFormController = searchTextFormController {
    init();
  }

  final BuildContext _context;

  final FocusNode _diaryTextFormFocusNode;
  final DiaryLocalService _localService;
  final TextEditingController _diaryTextFormController;
  final TextEditingController _searchTextFormController;
  DiaryData? _diaryData;
  String? _searchedValue;
  late String _localPath;

  List<DiaryData> _diaryDataList = [];
  List<DiaryData> _searchedData = [];

  bool _isLargeTextForm = false;
  bool _isSearchState = false;

  BuildContext get context => _context;

  bool get isSearchState => _isSearchState;

  bool get isLargeTextForm => _isLargeTextForm;

  TextEditingController get searchTextFormController =>
      _searchTextFormController;

  TextEditingController get diaryTextFormController => _diaryTextFormController;

  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;

  DiaryData? get diaryData => _diaryData;

  List<DiaryData> get diaryDataList => _diaryDataList;

  List<DiaryData> get searchedData => _searchedData;

  String get localPath => _localPath;

  set isLargeTextForm(bool isLargeTextForm) {
    _isLargeTextForm = isLargeTextForm;
    notifyListeners();
  }

  set isSearchState(bool isSearchState) {
    _isSearchState = isSearchState;
    notifyListeners();
  }

  void init() async {
    _localPath = (await getApplicationDocumentsDirectory()).path;
    _diaryTextFormController.addListener(() {
      if (_diaryData != null) {
        _diaryData =
            _diaryData?.copyWith(contents: _diaryTextFormController.text);
      } else {
        _diaryData = DiaryData(
          contents: _diaryTextFormController.text,
          time: DateTime.now(),
        );
      }
      notifyListeners();
    });
    getAllDiaryData();
  }

  Future<void> editDiaryData({
    required String contents,
    required DateTime date,
    String? cameraImage,
    List<String>? pickerImage,
    String? locate,
  }) async {
    await _localService.editDiaryData(
      diaryData: DiaryData(
        contents: contents,
        time: date,
        cameraImage: cameraImage,
        pickerImages: pickerImage,
        locate: locate,
      ),
    );
  }

  double handleDiaryTextFormFieldHeight() {
    if (!isLargeTextForm) return 100.h;

    return MediaQuery.of(_context).size.height -
        MediaQuery.of(_context).viewInsets.bottom -
        _handleFillImageHeight();
  }

  double _handleFillImageHeight() {
    return (_diaryData?.cameraImage != null || _diaryData?.pickerImages != null)
        ? 166.h
        : 100.h;
  }

  void onCheckBoxIconPressed() async {
    if (_diaryData == null || _diaryData!.contents.isEmpty) return;

    await _localService.setDiaryData(
      diaryData: _diaryData!.copyWith(
        time: DateTime.now(),
      ),
    );
    _diaryData = null;
    getAllDiaryData();
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

  void reSizedDiaryTextFormField() {
    isLargeTextForm = !_isLargeTextForm;

    if (_isLargeTextForm == true) {
      _diaryTextFormFocusNode.requestFocus();
    } else {
      _diaryTextFormFocusNode.unfocus();
    }
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

  bool isSameDay(DiaryData data, int idx) {
    if (idx - 1 < 0) return false;

    DiaryData previousData = _diaryDataList[idx - 1];
    return data.time.year == previousData.time.year &&
        data.time.month == previousData.time.month &&
        data.time.day == previousData.time.day;
  }

  void getAllDiaryData() {
    _diaryDataList = _localService.getAllDiaryData();
    _diaryDataList.sort((a, b) {
      return a.time.compareTo(b.time);
    });
    _diaryDataList = _diaryDataList.reversed.toList();

    _getSearchedData();

    notifyListeners();
  }

  void _getSearchedData() {
    _searchedData = [];
    if (_searchedValue == null) return;

    _diaryDataList.forEach((diaryData) {
      if (diaryData.contents.contains(_searchedValue!)) {
        _searchedData.add(diaryData);
      }
    });
  }

  void handleSearchedDataChanged(String value) {
    _searchedValue = value;
    _searchedData = [];
    if (value.isEmpty) {
      notifyListeners();
      return;
    }

    _diaryDataList.forEach((diaryData) {
      if (diaryData.contents.contains(value)) {
        _searchedData.add(diaryData);
      }
    });

    notifyListeners();
  }

  void onCameraPressed(String fileName) {
    if (_diaryData != null) {
      _diaryData = _diaryData!.copyWith(
        cameraImage: fileName,
      );
    } else {
      _diaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        cameraImage: fileName,
      );
    }
    notifyListeners();
  }

  void onImagesPressed(List<String> fileNames) {
    if (_diaryData != null) {
      _diaryData = _diaryData!.copyWith(
        pickerImages: fileNames,
      );
    } else {
      _diaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        pickerImages: fileNames,
      );
    }
    notifyListeners();
  }

  void onDeletePressed() {
    _diaryTextFormController.clear();
    _diaryData = null;
    _context.pop();
    notifyListeners();
  }

  void onSavePressed() async {
    if (_diaryData == null || _diaryData!.contents.isEmpty) return;

    await _localService.setDiaryData(
      diaryData: _diaryData!.copyWith(
        time: DateTime.now(),
      ),
    );
    _diaryData = null;
    getAllDiaryData();
    reSizedDiaryTextFormField();
    _diaryTextFormController.clear();
    notifyListeners();
  }

  void _onEditPressed(DiaryData data) {
    context.go(DiaryEditPage.id, extra: data);
    context.pop();
    notifyListeners();
  }

  void onItemPressed(DiaryData data) async {
    await ModalHelper.openDiaryDetailModal(
      context: _context,
      diaryData: data,
      localPath: _localPath,
      onEditPressed: () => _onEditPressed(data),
    );
    getAllDiaryData();
  }

  Future<bool> onBackButtonPressed() async {
    if (_isSearchState == true) {
      _isSearchState = false;
      _searchTextFormController.clear();
      _searchedValue = null;
      _searchedData = [];
      notifyListeners();
    }

    return false;
  }
}
