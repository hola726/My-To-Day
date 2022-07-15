import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/screens/main/diary_calendar_screen.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:my_to_day/utils/modal_helper.dart';
import 'package:my_to_day/widgets/common/diary_item.dart';
import 'package:my_to_day/widgets/common/diary_text_form_field.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:my_to_day/widgets/diary_text_form_option.dart';
import 'package:provider/provider.dart';

class DiaryScreen extends StatelessWidget {
  static const id = '/DiaryScreen';
  const DiaryScreen._({
    Key? key,
    required DiaryProvider diaryProvider,
    required DataProvider dataProvider,
  })  : _diaryProvider = diaryProvider,
        _dataProvider = dataProvider,
        super(key: key);

  final DiaryProvider _diaryProvider;
  final DataProvider _dataProvider;

  static Widget setProviderRoute() {
    return ChangeNotifierProvider<DiaryProvider>(
      create: (BuildContext context) => DiaryProvider(
        context: context,
        diaryTextFormFocusNode: FocusNode(),
        dataProvider: context.read<DataProvider>(),
        localStorageHelper: LocalStorageHelper(),
        diaryTextFormController: TextEditingController(),
        searchTextFormController: TextEditingController(),
      ),
      child: Consumer2<DiaryProvider, DataProvider>(
        builder: (_, diaryProvider, dataProvider, __) => DiaryScreen._(
          diaryProvider: diaryProvider,
          dataProvider: dataProvider,
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Container(
      color: Colors.black,
      child: _diaryProvider.isSearchState == true
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _dataProvider.filteredReversedData.length,
                    itemBuilder: (context, index) {
                      DiaryData? data =
                          _dataProvider.filteredReversedData[index];
                      DiaryData? previousData = 0 <= index - 1
                          ? _dataProvider.filteredReversedData[index - 1]
                          : null;

                      return data == null
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_dataProvider.isSameDay(
                                        data, previousData) ==
                                    false)
                                  SubTitleData(data: data),
                                DiaryItem(
                                  data: data,
                                  dataProvider: _dataProvider,
                                  onTap: () {
                                    _dataProvider.targetDataIndex = index;

                                    _dataProvider.diaryData = data;
                                    ModalHelper.openDiaryDetailModal(
                                      dataProvider: _dataProvider,
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
            )
          : Column(
              children: [
                DiaryTextFormField(
                  diaryProvider: _diaryProvider,
                  controller: _diaryProvider.diaryTextFormController,
                  height: _diaryProvider.isLargeTextForm
                      ? MediaQuery.of(_diaryProvider.context).size.height -
                          MediaQuery.of(_diaryProvider.context)
                              .viewInsets
                              .bottom -
                          _dataProvider.handleFillImageHeight()
                      : 100.h,
                  hintText: "오늘은...",
                  initialImage: _dataProvider.tmpDiaryData?.cameraImage,
                  initialPickerImages: _dataProvider.tmpDiaryData?.pickerImages,
                  handleOnChanged: _diaryProvider.handleDiaryTextFormChanged,
                  isDisableIcon: _diaryProvider.isLargeTextForm,
                  suffixIcon: IconButton(
                    padding: EdgeInsets.all(10.w),
                    onPressed: () async {
                      await _diaryProvider.setDiaryData(
                        contents: _diaryProvider.diaryTextFormController.text,
                        cameraImage: _dataProvider.tmpDiaryData?.cameraImage,
                        pickerImage: _dataProvider.tmpDiaryData?.pickerImages,
                        locate: _dataProvider.tmpDiaryData?.locate,
                      );
                      _dataProvider.tmpDiaryData = null;
                      _dataProvider.getAllDiaryData();
                      _diaryProvider.diaryTextFormController.clear();
                    },
                    iconSize: 55.w,
                    icon: Icon(
                      Icons.check_box,
                      color:
                          _diaryProvider.diaryTextFormController.text.isNotEmpty
                              ? AppTheme.errorColor
                              : AppTheme.backdropOverlay_65,
                    ),
                  ),
                  textFocusNode: _diaryProvider.diaryTextFormFocusNode,
                ),
                DiaryTextFormOption(
                  diaryProvider: _diaryProvider,
                  dataProvider: _dataProvider,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _dataProvider.allDiaryData.length,
                    itemBuilder: (context, index) {
                      DiaryData data = _dataProvider.reversedData[index];
                      DiaryData? previousData = 0 <= index - 1
                          ? _dataProvider.reversedData[index - 1]
                          : null;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_dataProvider.isSameDay(data, previousData) ==
                              false)
                            SubTitleData(data: data),
                          DiaryItem(
                            data: data,
                            dataProvider: _dataProvider,
                            onTap: () {
                              _dataProvider.targetDataIndex = index;

                              _dataProvider.diaryData = data;
                              ModalHelper.openDiaryDetailModal(
                                context: context,
                                dataProvider: _dataProvider,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget? buildLeading() {
    if (_diaryProvider.isSearchState == true) return null;

    if (_diaryProvider.isLargeTextForm == true) {
      return IconButton(
        onPressed: _diaryProvider.reSizedDiaryTextFormField,
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
            onPressed: () => _diaryProvider.isSearchState = true,
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

  List<Widget>? buildSearchWidgets() {
    return [
      IconButton(
        onPressed: () => _diaryProvider.isSearchState = false,
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
          controller: _diaryProvider.searchTextFormController,
          diaryProvider: _diaryProvider,
          hintText: CS.SEARCH,
          handleOnChanged: _dataProvider.handleFilteredDataChanged,
          hintStyle: AppTheme.button_large_KR.copyWith(
            color: AppTheme.grey800,
          ),
          textStyle: AppTheme.button_large_KR.copyWith(
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _diaryProvider.searchTextFormController.clear();
              _dataProvider.handleFilteredDataChanged(
                  _diaryProvider.searchTextFormController.text);
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

  Widget? buildRightTopWidget() {
    if (_diaryProvider.isSearchState == true) return null;
    if (_diaryProvider.isLargeTextForm == true) {
      return IconButton(
        onPressed: () async {
          await _diaryProvider.setDiaryData(
            contents: _diaryProvider.diaryTextFormController.text,
            cameraImage: _dataProvider.tmpDiaryData?.cameraImage,
            pickerImage: _dataProvider.tmpDiaryData?.pickerImages,
            locate: _dataProvider.tmpDiaryData?.locate,
          );
          _dataProvider.tmpDiaryData = null;
          _dataProvider.getAllDiaryData();
          _diaryProvider.reSizedDiaryTextFormField();
          _diaryProvider.diaryTextFormController.clear();
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
      );
    } else {
      return IconButton(
        onPressed: () => Navigator.of(_diaryProvider.context)
            .pushNamed(DiaryCalendarScreen.id),
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
    return GestureDetector(
      onTap: _diaryProvider.gestureOnTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          title: _diaryProvider.isLargeTextForm ? "WRITE" : "MYTODAY",
          leadingWidth: _diaryProvider.isLargeTextForm == true ? null : 200.w,
          leading: buildLeading(),
          appBarWidgets: buildSearchWidgets(),
          rightTopWidget: buildRightTopWidget(),
          bottomShadow: true,
          titleColor: AppTheme.primaryContrastColor,
          backgroundColors: AppTheme.textPrimaryColor,
        ),
        body: _buildMain(),
      ),
    );
  }
}

class SubTitleData extends StatelessWidget {
  const SubTitleData({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DiaryData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Text(
        DateHelper.convertDateMonth(data.time),
        style: AppTheme.button_small.copyWith(
          color: AppTheme.grey400,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
