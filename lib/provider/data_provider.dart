import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DataProvider extends ChangeNotifier {
  DataProvider({
    required LocalStorageHelper localStorageHelper,
  }) : _localStorageHelper = localStorageHelper {
    init();
  }

  final LocalStorageHelper _localStorageHelper;
  late List<DiaryData> _allDiaryData;
  DiaryData? _diaryData;
  DiaryData? _tmpDiaryData;
  late List<DiaryData> _reversedData =
      _allDiaryData.reversed.map((data) => data).toList();
  List<DiaryData?> _filteredReversedData = [];
  late List<DiaryData?> _selectDateReversedData = _allDiaryData
      .map((diaryData) {
        if (diaryData.time.year == DateTime.now().year &&
            diaryData.time.month == DateTime.now().month &&
            diaryData.time.day == DateTime.now().day) {
          return diaryData;
        }
      })
      .toList()
      .reversed
      .map((data) => data)
      .toList();
  int _targetDataIndex = 0;
  String? _filteredValue;
  DateTime _selectDate = DateTime.now();
  String? _localPath;

  DiaryData? get diaryData => _diaryData;
  String? get localPath => _localPath;

  DiaryData? get tmpDiaryData => _tmpDiaryData;

  List<DiaryData> get allDiaryData => _allDiaryData;

  List<DiaryData> get reversedData => _reversedData;

  List<DiaryData?> get filteredReversedData => _filteredReversedData;
  List<DiaryData?> get selectDateReversedData => _selectDateReversedData;

  int get targetDataIndex => _targetDataIndex;

  set diaryData(DiaryData? diaryData) {
    _diaryData = diaryData;
    notifyListeners();
  }

  set selectDateReversedData(List<DiaryData?> selectDateReversedData) {
    _selectDateReversedData = selectDateReversedData;
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

  void init() async {
    getAllDiaryData();
    _localPath = (await getApplicationDocumentsDirectory()).path;
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

  void getSelectDateData() {
    _selectDateReversedData = _allDiaryData
        .map((diaryData) {
          if (diaryData.time.year == _selectDate.year &&
              diaryData.time.month == _selectDate.month &&
              diaryData.time.day == _selectDate.day) {
            return diaryData;
          }
        })
        .toList()
        .reversed
        .map((data) => data)
        .toList();
    notifyListeners();
  }

  bool isSameDay(DiaryData data, DiaryData? previousData) {
    return data.time.year == previousData?.time.year &&
        data.time.month == previousData?.time.month &&
        data.time.day == previousData?.time.day;
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

  void handleSelectDateDataChanged(DateTime date) {
    _selectDate = date;
    _selectDateReversedData = _allDiaryData
        .map((diaryData) {
          if (diaryData.time.year == date.year &&
              diaryData.time.month == date.month &&
              diaryData.time.day == date.day) {
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

  void _editPhoto(String? photo) {
    if (_diaryData != null) {
      diaryData = _diaryData!.copyWith(
        cameraImage: photo,
      );
    }
  }

  void _setPhoto(String? photo) {
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
    final String? photoString = photo != null ? photo.path : null;
    if (isEdit == true) {
      _editPhoto(photoString);
    } else {
      _setPhoto(photoString);
    }
  }

  void _setPickerImages(List<String>? images) {
    if (_tmpDiaryData != null) {
      tmpDiaryData = _tmpDiaryData!.copyWith(
        pickerImages: images,
      );
    } else {
      tmpDiaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        pickerImages: images,
      );
    }
  }

  void _editPickerImages(List<String>? images) {
    if (_diaryData != null) {
      diaryData = _diaryData!.copyWith(
        pickerImages: images,
      );
    }
  }

  void getPickerImages(bool? isEdit) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    final String path = (await getApplicationDocumentsDirectory()).path;

    print(images!.first.name);
    print(File(images.first.path).path);

    List<String>? imageStrings;

    for (XFile image in images) {
      String localPath = "$path/${image.name}";

      print("test");
      print(localPath);

      await File(image.path).copy(localPath);
      // await image.saveTo(localPath);

      print(File(localPath));

      if (imageStrings == null) {
        imageStrings = [image.name];
      } else {
        imageStrings.add(image.name);
      }
    }

    if (isEdit == true) {
      _editPickerImages(imageStrings);
    } else {
      _setPickerImages(imageStrings);
    }
  }

  Color setPhotoColor(bool? isEdit) {
    return isEdit == true
        ? _diaryData?.cameraImage != null
            ? Colors.red
            : Colors.white
        : _tmpDiaryData?.cameraImage != null
            ? Colors.red
            : Colors.white;
  }

  Color setPickerImageColor(bool? isEdit) {
    print(_tmpDiaryData?.pickerImages);
    return isEdit == true
        ? _diaryData?.pickerImages != null
            ? Colors.red
            : Colors.white
        : _tmpDiaryData?.pickerImages != null
            ? Colors.red
            : Colors.white;
  }

  int handleSwipeItemCount() {
    if (_diaryData?.cameraImage != null && _diaryData?.pickerImages != null) {
      return _diaryData!.pickerImages!.length + 1;
    }
    if (_diaryData?.cameraImage != null) {
      return 1;
    }

    return _diaryData!.pickerImages!.length;
  }

  Widget handleSwipeItemBuilder(BuildContext context, int index) {
    bool isExistCameraImage = _diaryData?.cameraImage != null;
    if (isExistCameraImage && index == 0) {
      return Image.file(
        File(
          "$_localPath/${_diaryData!.cameraImage!}",
        ),
      );
    }
    return Image.file(
      File(
        "$_localPath/${_diaryData!.pickerImages![index - (isExistCameraImage ? 1 : 0)]}",
      ),
    );
  }

  void onShareButtonPressed() {
    String data = diaryData!.contents;
    if (diaryData?.pickerImages == null && diaryData?.cameraImage == null) {
      Share.share(
        data,
        subject: data,
      );
      return;
    }
    List<String> images = [];
    if (diaryData?.cameraImage != null) {
      images.add(diaryData!.cameraImage!);
    }
    if (diaryData?.pickerImages != null) {
      images.addAll(diaryData!.pickerImages!);
    }

    Share.shareFiles(
      images,
      text: data,
      subject: data,
    );
  }
}
