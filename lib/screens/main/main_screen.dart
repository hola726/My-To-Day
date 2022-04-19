import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/utils/local_storage_helper.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:my_to_day/widgets/common/my_to_day_text_form_field.dart';

class MainScreen extends StatefulWidget {
  static const id = "/MainScreen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final LocalStorageHelper _localStorageHelper = LocalStorageHelper();
  late List<DiaryData> _diaryData;

  @override
  void initState() {
    super.initState();
    _diaryData = _localStorageHelper.getAllDiaryData();
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
              _localStorageHelper.setDiaryData(
                  date: DateTime.now().toString(),
                  diaryDataModel:
                      DiaryData(contents: value, time: DateTime.now()));
              _diaryData = _localStorageHelper.getAllDiaryData();
              setState(() {});
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
              itemCount: _diaryData.length,
              itemBuilder: (context, index) {
                DiaryData data = _diaryData[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateHelper.convertDateMonth(data.time),
                      style: AppTheme.button_small.copyWith(
                        color: AppTheme.grey400,
                        fontSize: 11.sp,
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppTheme.commonBlack,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.contents,
                                  style: AppTheme.button_small_KR.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateHelper.convertDateAmPm(data.time),
                                  style: AppTheme.button_small_KR.copyWith(
                                    color: AppTheme.grey400,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
