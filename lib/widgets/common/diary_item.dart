import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:path_provider/path_provider.dart';

import '../../app_theme.dart';

class DiaryItem extends StatefulWidget {
  const DiaryItem({
    Key? key,
    required this.data,
    required this.dataProvider,
    this.onTap,
  }) : super(key: key);

  final DiaryData data;
  final void Function()? onTap;
  final DataProvider dataProvider;

  @override
  State createState() => _DiaryItemState();
}

class _DiaryItemState extends State<DiaryItem> {
  bool _isViewMore = false;
  String? _localPath;

  late final bool _isLongLineContents = widget.data.contents.length > 93;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _localPath = (await getApplicationDocumentsDirectory()).path;
  }

  String _getPath() {
    if (widget.data.cameraImage != null) {
      return "$_localPath/${widget.data.cameraImage}";
    }

    return "$_localPath/${widget.data.pickerImages![0]}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 3.h,
      ),
      child: InkWell(
        onTap: widget.onTap,
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
                        widget.data.contents,
                        maxLines: _isViewMore ? null : 3,
                        style: AppTheme.button_small_KR.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      if (!_isLongLineContents || _isViewMore == true)
                        Text(
                          DateHelper.convertDateAmPm(widget.data.time),
                          style: AppTheme.button_small_KR.copyWith(
                            color: AppTheme.grey400,
                            fontSize: 11.sp,
                          ),
                        ),
                      if (_isLongLineContents)
                        InkWell(
                          onTap: () => setState(() {
                            _isViewMore = !_isViewMore;
                          }),
                          child: Text(
                            _isViewMore ? '접기' : '더보기',
                            style: AppTheme.button_small_KR.copyWith(
                              decoration: TextDecoration.underline,
                              color: AppTheme.grey400,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                if ((widget.data.cameraImage != null ||
                        widget.data.pickerImages != null) &&
                    _localPath != null)
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
