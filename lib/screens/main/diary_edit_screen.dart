import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:my_to_day/widgets/common/diary_text_form_field.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:my_to_day/widgets/diary_text_form_option.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class DiaryEditScreen extends StatelessWidget {
  static const id = '/DiaryEditScreen';
  DiaryEditScreen._({
    Key? key,
    required DiaryProvider diaryProvider,
    required DataProvider dataProvider,
  })  : _diaryProvider = diaryProvider,
        _dataProvider = dataProvider,
        super(key: key) {
    _diaryProvider.diaryTextFormFocusNode.requestFocus();
  }

  final DiaryProvider _diaryProvider;
  final DataProvider _dataProvider;
  double _bottom = 0;

  static Widget setProviderRoute() {
    return ChangeNotifierProvider<DiaryProvider>(
      create: (BuildContext context) => DiaryProvider(
        context: context,
        diaryTextFormFocusNode: FocusNode(),
        localStorageHelper: LocalStorageHelper(),
        dataProvider: context.read<DataProvider>(),
        diaryTextFormController: TextEditingController(),
        searchTextFormController: TextEditingController(),
      ),
      child: Consumer2<DiaryProvider, DataProvider>(
        builder: (_, diaryProvider, dataProvider, __) => DiaryEditScreen._(
          diaryProvider: diaryProvider,
          dataProvider: dataProvider,
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          DiaryTextFormField(
            diaryProvider: _diaryProvider,
            controller: _diaryProvider.diaryTextFormController,
            height: MediaQuery.of(_diaryProvider.context).size.height -
                _bottom -
                _dataProvider.handleEditImageHeight(),
            hintText: "오늘은...",
            initialText: _dataProvider.diaryData?.contents,
            initialImage: _dataProvider.diaryData?.cameraImage,
            initialPickerImages: _dataProvider.diaryData?.pickerImages,
            isDisableIcon: true,
            textFocusNode: _diaryProvider.diaryTextFormFocusNode,
            isEditTextFormOption: true,
          ),
          DiaryTextFormOption(
            diaryProvider: _diaryProvider,
            dataProvider: _dataProvider,
            isEditTextFormOption: true,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        title: 'EDIT',
        bottomShadow: true,
        titleColor: AppTheme.primaryContrastColor,
        backgroundColors: AppTheme.textPrimaryColor,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.clear,
            size: 27.w,
          ),
        ),
        rightTopWidget: IconButton(
          onPressed: () async {
            await _diaryProvider.editDiaryData(
              contents: _diaryProvider.diaryTextFormController.text,
              date: _dataProvider.diaryData!.time,
              cameraImage: _dataProvider.diaryData?.cameraImage,
              pickerImage: _dataProvider.diaryData?.pickerImages,
              locate: _dataProvider.diaryData?.locate,
            );
            _dataProvider.getAllDiaryData();
            _diaryProvider.diaryTextFormController.clear();
            Navigator.of(context).pop();
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          color: _diaryProvider.diaryTextFormController.text.isNotEmpty
              ? Colors.red
              : null,
          icon: Icon(
            Icons.check,
            size: 27.w,
          ),
        ),
      ),
      body: _buildMain(),
    );
  }
}
