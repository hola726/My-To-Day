import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/routes.dart';
import 'package:my_to_day/screens/main/diary_edit_screen.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
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
        builder: (_, diaryProvider, __) => DiaryScreen._(
          diaryProvider: diaryProvider,
        ),
      ),
    );
  }

  void openEditBottomModal(DiaryData data) {
    showModalBottomSheet(
        context: _diaryProvider.context,
        backgroundColor: AppTheme.textSecondary2Color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 70.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    routeWithFullScreenDialog(DiaryEditScreen.id),
                  ),
                  iconSize: 20.h,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                IconButton(
                  onPressed: () =>
                      _diaryProvider.onShareButtonPressed(data.contents),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iconSize: 20.h,
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        });
  }

  void openBottomModal(DiaryData data) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: _diaryProvider.context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            minChildSize: 0.9999,
            initialChildSize: 1,
            builder: (context, scrollController) => StatefulBuilder(
                builder: (BuildContext context, StateSetter modalSetState) {
              return Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppBar().preferredSize.height,
                    horizontal: 20.w,
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: Navigator.of(context).pop,
                          icon: const Icon(
                            Icons.cancel,
                            color: AppTheme.grey600,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateHelper.convertDateMonth(data.time),
                            style: AppTheme.button_small.copyWith(
                              color: AppTheme.grey400,
                              fontSize: 11.sp,
                            ),
                          ),
                          IconButton(
                            onPressed: () => openEditBottomModal(data),
                            icon: const Icon(
                              Icons.more_horiz_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        data.contents,
                        style: AppTheme.button_small_KR.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        DateHelper.convertDateAmPm(data.time),
                        style: AppTheme.button_small.copyWith(
                          color: AppTheme.grey400,
                          fontSize: 11.sp,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  Widget _buildMain() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          DiaryTextFormField(
            diaryProvider: _diaryProvider,
            controller: _diaryProvider.textEditingController,
            height: _diaryProvider.isLargeTextForm
                ? MediaQuery.of(_diaryProvider.context).size.height -
                    MediaQuery.of(_diaryProvider.context).viewInsets.bottom -
                    116.h
                : 100.h,
            hintText: "오늘은...",
            isDisableIcon: _diaryProvider.isLargeTextForm,
            onIconPressed: (value) async {
              await _diaryProvider.setDiaryData(value);
              _diaryProvider.getDiaryData();
            },
            textFocusNode: _diaryProvider.diaryTextFormFocusNode,
          ),
          DiaryTextFormOption(diaryProvider: _diaryProvider),
          Expanded(
            child: ListView.builder(
              itemCount: _diaryProvider.allDiaryData.length,
              itemBuilder: (context, index) {
                DiaryData data = _diaryProvider.reversedData[index];
                DiaryData? previousData = 0 <= index - 1
                    ? _diaryProvider.reversedData[index - 1]
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_diaryProvider.isSameDay(data, previousData) == false)
                      SubTitleData(data: data),
                    DiaryItem(
                      data: data,
                      onTap: () {
                        _diaryProvider.diaryData = data;
                        openBottomModal(data);
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _diaryProvider.gestureOnTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(
          title: _diaryProvider.isLargeTextForm ? "WRITE" : "MYTODAY",
          leading: _diaryProvider.isLargeTextForm == true
              ? IconButton(
                  onPressed: _diaryProvider.reSizedDiaryTextFormField,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.clear,
                    size: 27.w,
                  ),
                )
              : null,
          rightTopWidget: _diaryProvider.isLargeTextForm == true
              ? IconButton(
                  onPressed: () async {
                    await _diaryProvider.setDiaryData(
                        _diaryProvider.textEditingController.text);
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
                )
              : null,
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
