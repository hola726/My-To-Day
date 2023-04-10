import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
  String? _filteredValue;
  String? _localPath;

  List<DiaryData> _allDiaryData = [];
  List<DiaryData> _reversedData = [];
  List<DiaryData?> _filteredReversedData = [];

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

  List<DiaryData> get allDiaryData => _allDiaryData;

  List<DiaryData> get reversedData => _reversedData;

  List<DiaryData?> get filteredReversedData => _filteredReversedData;

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

  Future<void> setDiaryData({
    required String contents,
    String? cameraImage,
    List<String>? pickerImage,
    String? locate,
  }) async {
    DateTime time = DateTime.now();
    await _localService.setDiaryData(
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
      cameraImage: _diaryData?.cameraImage,
      pickerImage: _diaryData?.pickerImages,
      locate: _diaryData?.locate,
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

  bool isSameDay(DiaryData data, DiaryData? previousData) {
    return data.time.year == previousData?.time.year &&
        data.time.month == previousData?.time.month &&
        data.time.day == previousData?.time.day;
  }

  void getAllDiaryData() {
    _allDiaryData = _localService.getAllDiaryData();
    getReversedData();
    notifyListeners();
  }

  void getReversedData() {
    _reversedData = _allDiaryData.reversed.map((data) => data).toList();
    _getFilteredReversedData();
  }

  void _getFilteredReversedData() {
    if (_filteredValue == null) {
      _filteredReversedData = [];
      return;
    }

    _filteredReversedData = _allDiaryData
        .map((diaryData) {
          if (diaryData.contents.contains(_filteredValue!)) {
            return diaryData;
          }
        })
        .toList()
        .reversed
        .map((data) => data)
        .toList();
  }

  void handleFilteredDataChanged(String value) {
    _filteredValue = value;
    if (value == '') {
      _filteredReversedData = [];
      notifyListeners();
      return;
    }

    _filteredReversedData = _allDiaryData
        .map((diaryData) {
          if (diaryData.contents.contains(value)) {
            return diaryData;
          }
        })
        .toList()
        .reversed
        .map((data) => data)
        .toList();
    notifyListeners();
  }

  void onCameraPressed() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final String path = (await getApplicationDocumentsDirectory()).path;

      String localPath = "$path/${photo.name}";
      await File(photo.path).copy(localPath);

      String photoString = photo.name;

      _setPhoto(photoString);
    }
  }

  void _setPhoto(String? photo) {
    if (_diaryData != null) {
      _diaryData = _diaryData!.copyWith(
        cameraImage: photo,
      );
    } else {
      _diaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        cameraImage: photo,
      );
    }
    notifyListeners();
  }

  void onImagesPressed() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images == null) return;

    final String path = (await getApplicationDocumentsDirectory()).path;

    List<String>? imageStrings;

    for (XFile image in images) {
      String localPath = "$path/${image.name}";

      await File(image.path).copy(localPath);

      if (imageStrings == null) {
        imageStrings = [image.name];
      } else {
        imageStrings.add(image.name);
      }
    }

    _setPickerImages(imageStrings);
  }

  void _setPickerImages(List<String>? images) {
    if (_diaryData != null) {
      _diaryData = _diaryData!.copyWith(
        pickerImages: images,
      );
    } else {
      _diaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        pickerImages: images,
      );
    }
    notifyListeners();
  }

  Widget imageItemBuilder(BuildContext context, int index, DiaryData data) {
    bool isExistCameraImage = data.cameraImage != null;
    if (isExistCameraImage && index == 0) {
      return Image.file(
        File(
          "$_localPath/${data.cameraImage!}",
        ),
      );
    }
    return Image.file(
      File(
        "$_localPath/${data.pickerImages![index - (isExistCameraImage ? 1 : 0)]}",
      ),
    );
  }

  int handleImageItemCount(DiaryData data) {
    if (data.cameraImage != null && data.pickerImages != null) {
      return data.pickerImages!.length + 1;
    }
    if (data.cameraImage != null) {
      return 1;
    }
    if (data.pickerImages == null) return 0;

    return data.pickerImages!.length;
  }

  void onSharePressed(DiaryData data) {
    String contents = data.contents;
    if (data.pickerImages == null && data.cameraImage == null) {
      Share.share(
        contents,
        subject: contents,
      );
      return;
    }
    List<String> images = [];
    if (data.cameraImage != null) {
      images.add(data.cameraImage!);
    }
    if (data.pickerImages != null) {
      images.addAll(data.pickerImages!);
    }

    Share.shareFiles(
      images,
      text: contents,
      subject: contents,
    );
  }

  void onEditPressed(DiaryData data) {
    context.go(DiaryEditPage.id, extra: data);
    context.pop();
    notifyListeners();
  }

  void onOptionPressed(DiaryData data) async {
    await ModalHelper.openEditBottomModal(
      context: _context,
      onSharePressed: () => onSharePressed(data),
      onEditPressed: () => onEditPressed(data),
    );
    // dataProvider.getDiaryData();
  }

  void onDiaryItemTap(DiaryData data) {
    ModalHelper.openDiaryDetailModal(
      context: _context,
      diaryData: data,
      imageItemBuilder: (context, index) =>
          imageItemBuilder(context, index, data),
      imageItemCount: handleImageItemCount(data),
      onOptionPressed: () => onOptionPressed(data),
    );
  }

  void onDeletePressed() {
    _diaryTextFormController.clear();
    _diaryData = null;
    _context.pop();
    notifyListeners();
  }

  void onSavePressed() async {
    await setDiaryData(
      contents: _diaryTextFormController.text,
      cameraImage: _diaryData?.cameraImage,
      pickerImage: _diaryData?.pickerImages,
      locate: _diaryData?.locate,
    );
    _diaryData = null;
    getAllDiaryData();
    reSizedDiaryTextFormField();
    _diaryTextFormController.clear();
    notifyListeners();
  }

  void onItemPressed(DiaryData data) {
    ModalHelper.openDiaryDetailModal(
      context: _context,
      diaryData: data,
      imageItemBuilder: (context, index) =>
          imageItemBuilder(context, index, data),
      imageItemCount: handleImageItemCount(data),
      onOptionPressed: () => onOptionPressed(data),
    );
  }
}
