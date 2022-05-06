import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/widgets/common/diary_item.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:my_to_day/widgets/common/my_to_day_text_form_field.dart';
import 'package:provider/provider.dart';

class DiaryScreen extends StatelessWidget {
  static const id = "/DiaryScreen";

  late final DataProvider _dataProvider = _context.watch<DataProvider>();
  late BuildContext _context;

  void openEditBottomModal() {
    showModalBottomSheet(
        context: _context,
        constraints: BoxConstraints(
          maxWidth: 300.w,
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 100.h,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 100.w,
              ),
              child: Container(
                child: Row(
                  children: const [
                    Icon(Icons.restore),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void openBottomModal(DiaryData data) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: _context,
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
                            onPressed: openEditBottomModal,
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
          MyToDayTextFormField(
            height: 100.h,
            hintText: "오늘은...",
            onIconPressed: (value) {
              _dataProvider.setDiaryData(value);
              _dataProvider.getDiaryData();
            },
          ),
          Container(
            color: AppTheme.commonBlack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.zoom_out_map_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.restore_from_trash_outlined,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => {},
                  child: Text(
                    DateHelper.convertDate(DateTime.now()),
                    style: AppTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _dataProvider.allDiaryData?.length,
              itemBuilder: (context, index) {
                List<DiaryData> _reversedData = _dataProvider
                    .allDiaryData!.reversed
                    .map((data) => data)
                    .toList();
                DiaryData data = _reversedData[index];
                DiaryData? previousData =
                    0 <= index - 1 ? _reversedData[index - 1] : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_dataProvider.isSameDay(data, previousData) == false)
                      SubTitleData(data: data),
                    DiaryItem(
                      data: data,
                      onTap: () {
                        _dataProvider.diaryData = data;
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
    _context = context;
    return Scaffold(
      appBar: MainAppBar(
        title: "MYTODAY",
        bottomShadow: true,
        titleColor: AppTheme.primaryContrastColor,
        backgroundColors: AppTheme.textPrimaryColor,
      ),
      body: _buildMain(),
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
