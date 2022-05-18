import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/utils/date_helper.dart';

import '../../app_theme.dart';

class DiaryItem extends StatefulWidget {
  const DiaryItem({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  final DiaryData data;
  final void Function()? onTap;

  @override
  State createState() => _DiaryItemState();
}

class _DiaryItemState extends State<DiaryItem> {
  bool _isViewMore = false;
  late final bool _isLongLineContents = widget.data.contents.length > 93;

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
