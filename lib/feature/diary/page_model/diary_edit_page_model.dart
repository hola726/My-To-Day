import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/data/diary_data.dart';

class DiaryEditPageModel extends ChangeNotifier {
  DiaryEditPageModel({
    required BuildContext context,
    required DiaryData diaryData,
    required FocusNode diaryTextFormFocusNode,
    required DiaryLocalService diaryLocalService,
    required TextEditingController diaryTextFormController,
  })  : _context = context,
        _diaryData = diaryData,
        _localService = diaryLocalService,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _diaryTextFormController = diaryTextFormController {
    init();
  }

  final BuildContext _context;
  final FocusNode _diaryTextFormFocusNode;
  final DiaryLocalService _localService;
  final TextEditingController _diaryTextFormController;
  late final String _key;
  DiaryData? _diaryData;

  BuildContext get context => _context;
  DiaryData? get diaryData => _diaryData;
  TextEditingController get diaryTextFormController => _diaryTextFormController;
  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;

  void init() {
    _key = _diaryData!.key!;
    _diaryTextFormFocusNode.requestFocus();
    _diaryTextFormController.addListener(textControllerListener);
  }

  void textControllerListener() {
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
  }

  void onEditPressed() async {
    if (_diaryData == null || _diaryData!.contents.isEmpty) return;

    await _localService.editDiaryData(
      diaryData: _diaryData!
          .copyWith(key: _key, contents: _diaryTextFormController.text),
    );
    _diaryTextFormController.clear();
    _context.pop();
  }

  void onLeadingPressed() {
    _context.pop();
  }

  void _setPhoto(String? imageFileName) {
    if (_diaryData != null) {
      _diaryData = _diaryData!.copyWith(
        cameraImage: imageFileName,
      );
    } else {
      _diaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        cameraImage: imageFileName,
      );
    }
    notifyListeners();
  }

  void onCameraPressed() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final String path = (await getApplicationDocumentsDirectory()).path;

      String localPath = "$path/${photo.name}";
      await File(photo.path).copy(localPath);

      String imageFileName = photo.name;

      _setPhoto(imageFileName);
    }
  }

  void _setPickerImages(List<String>? imagesFileName) {
    if (_diaryData != null) {
      _diaryData = _diaryData!.copyWith(
        pickerImages: imagesFileName,
      );
    } else {
      _diaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        pickerImages: imagesFileName,
      );
    }
    notifyListeners();
  }

  void onImagesPressed() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images == null) return;

    final String path = (await getApplicationDocumentsDirectory()).path;

    List<String>? imagesFileName;

    for (XFile image in images) {
      String localPath = "$path/${image.name}";

      await File(image.path).copy(localPath);

      if (imagesFileName == null) {
        imagesFileName = [image.name];
      } else {
        imagesFileName.add(image.name);
      }
    }

    _setPickerImages(imagesFileName);
  }

  void onDeletePressed() {
    _diaryTextFormController.clear();
    _diaryData = null;
    _context.pop();
    notifyListeners();
  }

  double handleEditImageHeight() {
    return (_diaryData?.cameraImage != null || _diaryData?.pickerImages != null)
        ? 166.h
        : 116.h;
  }
}
