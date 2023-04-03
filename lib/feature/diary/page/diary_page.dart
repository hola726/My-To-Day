import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/feature/diary/page_model/diary_page_model.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/modal_helper.dart';
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
            itemCount: model.dataProvider.filteredReversedData.length,
            itemBuilder: (context, index) {
              DiaryData? data = model.dataProvider.filteredReversedData[index];
              DiaryData? previousData = 0 <= index - 1
                  ? model.dataProvider.filteredReversedData[index - 1]
                  : null;

              return data == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (model.dataProvider.isSameDay(data, previousData) ==
                            false)
                          SubTitleDate(data: data),
                        DiaryItem(
                          data: data,
                          dataProvider: model.dataProvider,
                          onTap: () {
                            model.dataProvider.targetDataIndex = index;

                            model.dataProvider.diaryData = data;
                            ModalHelper.openDiaryDetailModal(
                              dataProvider: model.dataProvider,
                              context: context,
                            );
                          },
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
      iconSize: 55.w,
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
          dataProvider: model.dataProvider,
          controller: model.diaryTextFormController,
          height: model.handleDiaryTextFormFieldHeight(),
          hintText: TODAY_IS,
          initialImage: model.dataProvider.tmpDiaryData?.cameraImage,
          initialPickerImages: model.dataProvider.tmpDiaryData?.pickerImages,
          handleOnChanged: model.handleDiaryTextFormChanged,
          isDisableIcon: model.isLargeTextForm,
          suffixIcon: _buildCheckBoxIcon(model),
          textFocusNode: model.diaryTextFormFocusNode,
          isLargeTextForm: model.isLargeTextForm,
        ),
        DiaryTextFormOption(
          dataProvider: model.dataProvider,
          context: model.context,
          diaryTextFormController: model.diaryTextFormController,
          isLargeTextForm: model.isLargeTextForm,
          reSizedDiaryTextFormField: model.reSizedDiaryTextFormField,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model.dataProvider.allDiaryData.length,
            itemBuilder: (context, index) {
              DiaryData data = model.dataProvider.reversedData[index];
              DiaryData? previousData = 0 <= index - 1
                  ? model.dataProvider.reversedData[index - 1]
                  : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.dataProvider.isSameDay(data, previousData) == false)
                    SubTitleDate(data: data),
                  DiaryItem(
                    data: data,
                    dataProvider: model.dataProvider,
                    onTap: () {
                      model.dataProvider.targetDataIndex = index;

                      model.dataProvider.diaryData = data;
                      ModalHelper.openDiaryDetailModal(
                        context: context,
                        dataProvider: model.dataProvider,
                      );
                    },
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
          size: 27.w,
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
        icon: Icon(
          Icons.arrow_back_ios,
          size: 25.w,
        ),
      ),
      IconButton(
        onPressed: () => {},
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.search,
          size: 27.w,
        ),
      ),
      SizedBox(
        width: 267.w,
        child: DiaryTextFormField(
          controller: model.searchTextFormController,
          dataProvider: model.dataProvider,
          hintText: CS.SEARCH,
          isLargeTextForm: model.isLargeTextForm,
          handleOnChanged: model.dataProvider.handleFilteredDataChanged,
          hintStyle: AppTheme.button_large_KR.copyWith(
            color: AppTheme.grey800,
          ),
          textStyle: AppTheme.button_large_KR.copyWith(
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              model.searchTextFormController.clear();
              model.dataProvider.handleFilteredDataChanged(
                  model.searchTextFormController.text);
            },
            splashColor: Colors.transparent,
            iconSize: 20.w,
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
        onPressed: () async {
          await model.setDiaryData(
            contents: model.diaryTextFormController.text,
            cameraImage: model.dataProvider.tmpDiaryData?.cameraImage,
            pickerImage: model.dataProvider.tmpDiaryData?.pickerImages,
            locate: model.dataProvider.tmpDiaryData?.locate,
          );
          model.dataProvider.tmpDiaryData = null;
          model.dataProvider.getAllDiaryData();
          model.reSizedDiaryTextFormField();
          model.diaryTextFormController.clear();
        },
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

    return GestureDetector(
      onTap: model.gestureOnTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          title: model.isLargeTextForm ? WRITE : MY_TO_DAY,
          leadingWidth: model.isLargeTextForm == true ? null : 200.w,
          leading: buildLeading(model),
          appBarWidgets: buildSearchWidgets(model),
          rightTopWidget: buildRightTopWidget(model),
          bottomShadow: true,
          titleColor: AppTheme.primaryContrastColor,
          backgroundColors: AppTheme.textPrimaryColor,
        ),
        body: _buildMain(model),
      ),
    );
  }
}
