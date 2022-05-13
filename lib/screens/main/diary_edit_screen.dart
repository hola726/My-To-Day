import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:my_to_day/widgets/common/diary_text_form_field.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:my_to_day/widgets/diary_text_form_option.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class DiaryEditScreen extends StatelessWidget {
  static const id = '/DiaryEditScreen';
  const DiaryEditScreen._({
    Key? key,
    required DiaryProvider diaryProvider,
  })  : _diaryProvider = diaryProvider,
        super(key: key);

  final DiaryProvider _diaryProvider;

  static Widget setProviderRoute() {
    return ChangeNotifierProvider<DiaryProvider>(
      create: (BuildContext context) => DiaryProvider(
        textEditingController: TextEditingController(),
        localStorageHelper: LocalStorageHelper(),
        diaryTextFormFocusNode: FocusNode(),
        context: context,
      ),
      child: Consumer<DiaryProvider>(
        builder: (_, diaryProvider, __) => DiaryEditScreen._(
          diaryProvider: diaryProvider,
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
            controller: _diaryProvider.textEditingController,
            height: MediaQuery.of(_diaryProvider.context).size.height -
                MediaQuery.of(_diaryProvider.context).viewInsets.bottom -
                116.h,
            hintText: "오늘은...",
            isDisableIcon: true,
            onIconPressed: (value) async {
              await _diaryProvider.setDiaryData(value);
              _diaryProvider.getDiaryData();
            },
            textFocusNode: _diaryProvider.diaryTextFormFocusNode,
          ),
          DiaryTextFormOption(diaryProvider: _diaryProvider),
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
            await _diaryProvider
                .setDiaryData(_diaryProvider.textEditingController.text);
            _diaryProvider.getDiaryData();
            _diaryProvider.reSizedDiaryTextFormField();
            _diaryProvider.textEditingController.clear();
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          color: _diaryProvider.textEditingController.text.isNotEmpty
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
