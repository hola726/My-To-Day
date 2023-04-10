import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/feature/diary/page_model/diary_edit_page_model.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../app_theme.dart';
import '../../../constants/constant_strings.dart';
import '../../../widgets/common/diary_text_form_field.dart';
import '../../../widgets/common/diary_text_form_option.dart';

class DiaryEditPage extends StatelessWidget {
  static const id = '/diaryEditPage';
  DiaryEditPage({
    Key? key,
  }) : super(key: key);

  Widget _buildMain(DiaryEditPageModel model, BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          DiaryTextFormField(
            controller: model.diaryTextFormController,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom -
                model.handleEditImageHeight(),
            hintText: TODAY_IS,
            initialText: model.diaryData.contents,
            initialImage: model.diaryData.cameraImage,
            initialPickerImages: model.diaryData.pickerImages,
            isDisableIcon: true,
            textFocusNode: model.diaryTextFormFocusNode,
            isEditTextFormOption: true,
          ),
          DiaryTextFormOption(
            diaryData: model.diaryData,
            onCameraPressed: model.onCameraPressed,
            onDeletePressed: model.onDeletePressed,
            onImagesPressed: model.onImagesPressed,
            context: model.context,
            diaryTextFormController: model.diaryTextFormController,
            isLargeTextForm: false,
            reSizedDiaryTextFormField: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLeading(DiaryEditPageModel model) {
    return IconButton(
      onPressed: model.onLeadingPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(
        Icons.clear,
        size: 27.w,
      ),
    );
  }

  Widget _buildRightTop(DiaryEditPageModel model) {
    return IconButton(
      onPressed: model.onEditPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      color: model.diaryTextFormController.text.isNotEmpty ? Colors.red : null,
      icon: Icon(
        Icons.check,
        size: 27.w,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DiaryEditPageModel model = context.watch<DiaryEditPageModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        title: EDIT,
        bottomShadow: true,
        titleColor: AppTheme.primaryContrastColor,
        backgroundColors: AppTheme.textPrimaryColor,
        leading: _buildLeading(model),
        rightTopWidget: _buildRightTop(model),
      ),
      body: _buildMain(model, context),
    );
  }
}
