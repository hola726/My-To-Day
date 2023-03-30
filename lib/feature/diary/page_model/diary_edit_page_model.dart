import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_to_day/feature/diary/service/diary_local_service.dart';

import '../../../model/data/diary_data.dart';
import '../../../provider/data_provider.dart';

class DiaryEditPageModel extends ChangeNotifier {
  DiaryEditPageModel({
    required BuildContext context,
    required DataProvider dataProvider,
    required FocusNode diaryTextFormFocusNode,
    required DiaryLocalService diaryLocalService,
    required TextEditingController diaryTextFormController,
  })  : _context = context,
        _dataProvider = dataProvider,
        _diaryLocalService = diaryLocalService,
        _diaryTextFormFocusNode = diaryTextFormFocusNode,
        _diaryTextFormController = diaryTextFormController {
    init();
  }

  final BuildContext _context;
  final DataProvider _dataProvider;
  final FocusNode _diaryTextFormFocusNode;
  final DiaryLocalService _diaryLocalService;
  final TextEditingController _diaryTextFormController;

  double _bottom = 0;

  double get bottom => _bottom;
  BuildContext get context => _context;
  DataProvider get dataProvider => _dataProvider;
  TextEditingController get diaryTextFormController => _diaryTextFormController;
  FocusNode get diaryTextFormFocusNode => _diaryTextFormFocusNode;

  void init() {
    _diaryTextFormFocusNode.requestFocus();
    _bottom = MediaQuery.of(_context).viewInsets.bottom;
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

  void onLeadingPressed() {
    _context.pop;
  }
}
