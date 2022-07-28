import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_theme.dart';
import '../../model/data/diary_data.dart';
import '../../utils/date_helper.dart';

class SubTitleDate extends StatelessWidget {
  const SubTitleDate({
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
