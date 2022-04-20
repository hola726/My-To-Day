import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/date_helper.dart';

import '../../app_theme.dart';

class DiaryItem extends StatelessWidget {
  DiaryItem({
    required this.data,
    this.height,
  });

  final DiaryData data;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 3.h,
      ),
      child: Container(
        height: height ?? 50.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppTheme.commonBlack,
          borderRadius: BorderRadius.circular(4),
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
    );
  }
}
