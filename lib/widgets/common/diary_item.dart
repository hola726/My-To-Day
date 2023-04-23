import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:my_to_day/model/data/diary_data.dart';

import '../../app_theme.dart';
import '../../utils/date_helper.dart';

class DiaryItem extends StatelessWidget {
  const DiaryItem({
    Key? key,
    required this.data,
    required this.localPath,
    this.onTap,
  }) : super(key: key);

  final DiaryData data;
  final String localPath;
  final void Function()? onTap;

  String _getPath() {
    if (data.cameraImage != null) {
      return "$localPath/${data.cameraImage}";
    }

    return "$localPath/${data.pickerImages![0]}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 3.h,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.contents,
                        maxLines: 3,
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
                ),
                SizedBox(width: 10.w),
                if ((data.cameraImage != null || data.pickerImages != null))
                  SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: InstaImageViewer(
                      child: Image.file(
                        File(
                          _getPath(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
