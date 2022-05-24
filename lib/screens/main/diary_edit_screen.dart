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

  static Widget setProviderRoute() {
    return ChangeNotifierProvider<DiaryProvider>(
      create: (BuildContext context) => DiaryProvider(
        diaryTextFormController: TextEditingController(),
        searchTextFormController: TextEditingController(),
        localStorageHelper: LocalStorageHelper(),
        diaryTextFormFocusNode: FocusNode(),
        context: context,
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
                MediaQuery.of(_diaryProvider.context).viewInsets.bottom -
                116.h,
            hintText: "오늘은...",
            initialValue: _dataProvider.diaryData?.contents,
            isDisableIcon: true,
            textFocusNode: _diaryProvider.diaryTextFormFocusNode,
          ),
          DiaryTextFormOption(
            diaryProvider: _diaryProvider,
            dataProvider: _dataProvider,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
