import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/feature/diary/page_model/diary_page_model.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/widgets/common/diary_item.dart';
import 'package:my_to_day/widgets/common/diary_text_form_field.dart';
import 'package:my_to_day/widgets/common/diary_text_form_option.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant_strings.dart';
import '../../../widgets/common/subtitle_date.dart';

class DiaryPage extends StatelessWidget {
  static const id = '/diaryPage';
  DiaryPage({Key? key}) : super(key: key);

  Widget _buildSearchPage(DiaryPageModel model) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: model.searchedData.length,
            itemBuilder: (context, index) {
              DiaryData? data = model.searchedData[index];
              DiaryData? previousData =
                  0 <= index - 1 ? model.searchedData[index - 1] : null;

              return data == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (model.isSameDay(data, previousData) == false)
                          SubTitleDate(data: data),
                        DiaryItem(
                          data: data,
                          localPath: model.localPath,
                          onTap: () => model.onItemPressed(data),
                        ),
                      ],
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckBoxIcon(DiaryPageModel model) {
    return IconButton(
      padding: EdgeInsets.all(10.w),
      onPressed: model.onCheckBoxIconPressed,
      iconSize: 55.sp,
      icon: Icon(
        Icons.check_box,
        color: model.diaryTextFormController.text.isNotEmpty
            ? AppTheme.errorColor
            : AppTheme.backdropOverlay_65,
      ),
    );
  }

  Widget _buildDiaryPage(DiaryPageModel model) {
    return Column(
      children: [
        DiaryTextFormField(
          controller: model.diaryTextFormController,
          height: model.handleDiaryTextFormFieldHeight(),
          hintText: TODAY_IS,
          initialImage: model.diaryData?.cameraImage,
          initialPickerImages: model.diaryData?.pickerImages,
          handleOnChanged: model.handleDiaryTextFormChanged,
          isDisableIcon: model.isLargeTextForm,
          suffixIcon: _buildCheckBoxIcon(model),
          textFocusNode: model.diaryTextFormFocusNode,
          isLargeTextForm: model.isLargeTextForm,
        ),
        DiaryTextFormOption(
          context: model.context,
          diaryTextFormController: model.diaryTextFormController,
          isLargeTextForm: model.isLargeTextForm,
          reSizedDiaryTextFormField: model.reSizedDiaryTextFormField,
          diaryData: model.diaryData,
          onCameraPressed: model.onCameraPressed,
          onImagesPressed: model.onImagesPressed,
          onDeletePressed: model.onDeletePressed,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model.diaryDataList.length,
            itemBuilder: (context, index) {
              DiaryData data = model.diaryDataList[index];
              DiaryData? previousData =
                  0 <= index - 1 ? model.diaryDataList[index - 1] : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.isSameDay(data, previousData) == false)
                    SubTitleDate(data: data),
                  DiaryItem(
                    data: data,
                    localPath: model.localPath,
                    onTap: () => model.onItemPressed(data),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMain(DiaryPageModel model) {
    return Container(
      color: Colors.black,
      child: model.isSearchState == true
          ? _buildSearchPage(model)
          : _buildDiaryPage(model),
    );
  }

  Widget? buildLeading(DiaryPageModel model) {
    if (model.isSearchState == true) return null;

    if (model.isLargeTextForm == true) {
      return IconButton(
        onPressed: model.reSizedDiaryTextFormField,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.clear,
          size: 27.sp,
        ),
      );
    } else {
      return Row(
        children: [
          IconButton(
            onPressed: () => {},
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.settings,
              size: 27.w,
            ),
          ),
          IconButton(
            onPressed: () => model.isSearchState = true,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.search,
              size: 27.w,
            ),
          ),
        ],
      );
    }
  }

  List<Widget>? buildSearchWidgets(DiaryPageModel model) {
    return [
      IconButton(
        onPressed: () => model.isSearchState = false,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconSize: 25.sp,
        icon: Icon(
          Icons.arrow_back_ios,
        ),
      ),
      IconButton(
        onPressed: () => {},
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconSize: 27.sp,
        icon: Icon(
          Icons.search,
        ),
      ),
      Expanded(
        child: DiaryTextFormField(
          controller: model.searchTextFormController,
          hintText: CS.SEARCH,
          isLargeTextForm: model.isLargeTextForm,
          handleOnChanged: model.handleSearchedDataChanged,
          hintStyle: AppTheme.button_large_KR.copyWith(
            color: AppTheme.grey800,
          ),
          textStyle: AppTheme.button_large_KR.copyWith(
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              model.searchTextFormController.clear();
              model.handleSearchedDataChanged(
                  model.searchTextFormController.text);
            },
            splashColor: Colors.transparent,
            iconSize: 20.sp,
            icon: Icon(
              Icons.cancel,
              color: AppTheme.grey200,
            ),
          ),
        ),
      ),
    ];
  }

  Widget? buildRightTopWidget(DiaryPageModel model) {
    if (model.isSearchState == true) return null;
    if (model.isLargeTextForm == true) {
      return IconButton(
        onPressed: model.onSavePressed,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        color:
            model.diaryTextFormController.text.isNotEmpty ? Colors.red : null,
        icon: Icon(
          Icons.check,
          size: 27.w,
        ),
      );
    } else {
      return IconButton(
        onPressed: model.onCalendarPressed,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.calendar_today,
          size: 27.w,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DiaryPageModel model = context.watch<DiaryPageModel>();

    return WillPopScope(
      onWillPop: model.onBackButtonPressed,
      child: GestureDetector(
        onTap: model.gestureOnTap,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MainAppBar(
            title: model.isLargeTextForm ? WRITE : MY_TO_DAY,
            leadingWidth: model.isLargeTextForm == true ? null : 115.w,
            leading: buildLeading(model),
            appBarWidgets: buildSearchWidgets(model),
            rightTopWidget: buildRightTopWidget(model),
            bottomShadow: true,
            titleColor: AppTheme.primaryContrastColor,
            backgroundColors: AppTheme.textPrimaryColor,
          ),
          body: _buildMain(model),
        ),
      ),
    );
  }
}
