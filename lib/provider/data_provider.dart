import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';

class DataProvider extends ChangeNotifier {
  DataProvider({
    required LocalStorageHelper localStorageHelper,
  }) : _localStorageHelper = localStorageHelper {
    getAllDiaryData();
  }

  final LocalStorageHelper _localStorageHelper;
  late List<DiaryData> _allDiaryData;
  DiaryData? _diaryData;
  DiaryData? _tmpDiaryData;
  late List<DiaryData> _reversedData =
      _allDiaryData.reversed.map((data) => data).toList();
  List<DiaryData?> _filteredReversedData = [];
  int _targetDataIndex = 0;
  String? _filteredValue;

  DiaryData? get diaryData => _diaryData;

  DiaryData? get tmpDiaryData => _tmpDiaryData;

  List<DiaryData> get allDiaryData => _allDiaryData;

  List<DiaryData> get reversedData => _reversedData;

  List<DiaryData?> get filteredReversedData => _filteredReversedData;

  int get targetDataIndex => _targetDataIndex;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }

  set tmpDiaryData(DiaryData? tmpDiaryData) {
    _tmpDiaryData = tmpDiaryData;
    notifyListeners();
  }

  set targetDataIndex(int targetDataIndex) {
    _targetDataIndex = targetDataIndex;
    notifyListeners();
  }

  set allDiaryData(List<DiaryData> allDiaryData) {
    _allDiaryData = allDiaryData;
    notifyListeners();
  }

  void getAllDiaryData() {
    _allDiaryData = _localStorageHelper.getAllDiaryData();
    getReversedData();
    notifyListeners();
  }

  void getDiaryData() {
    diaryData = _reversedData[_targetDataIndex];
  }

  void getReversedData() {
    _reversedData = _allDiaryData.reversed.map((data) => data).toList();
    _getFilteredReversedData();
  }

  void _getFilteredReversedData() {
    _filteredReversedData = _allDiaryData
        .map((diaryData) {
          if (diaryData.contents.contains(_filteredValue ?? '')) {
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

  double handleFillImageHeight() {
    return (tmpDiaryData?.cameraImage != null ||
            tmpDiaryData?.pickerImages != null)
        ? 166.h
        : 116.h;
  }

  double handleEditImageHeight() {
    return (_diaryData?.cameraImage != null || _diaryData?.pickerImages != null)
        ? 166.h
        : 116.h;
  }

  void _editPhoto(XFile? photo) {
    if (_diaryData != null) {
      print('edit photo');
      diaryData = _diaryData!.copyWith(
        cameraImage: photo,
      );
    }
  }

  void _setPhoto(XFile? photo) {
    if (_tmpDiaryData != null) {
      tmpDiaryData = _tmpDiaryData!.copyWith(
        cameraImage: photo,
      );
    } else {
      tmpDiaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        cameraImage: photo,
      );
    }
  }

  void getPhoto(bool? isEdit) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (isEdit == true) {
      _editPhoto(photo);
    } else {
      _setPhoto(photo);
    }
  }

  void _setPickerImages(List<XFile>? images) {
    if (_tmpDiaryData != null) {
      tmpDiaryData = _tmpDiaryData!.copyWith(
        pickerImages: images,
      );
    } else {
      _tmpDiaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        pickerImages: images,
      );
    }
  }

  void _editPickerImages(List<XFile>? images) {
    if (_diaryData != null) {
      diaryData = _diaryData!.copyWith(
        pickerImages: images,
      );
    }
  }

  void getPickerImages(bool? isEdit) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    if (isEdit == true) {
      _editPickerImages(images);
    } else {
      _setPickerImages(images);
    }
  }
}
