import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';

import '../app_theme.dart';
import 'common/contour.dart';

class DiaryTextFormOption extends StatelessWidget {
  const DiaryTextFormOption({
    Key? key,
    required DiaryProvider diaryProvider,
  })  : _diaryProvider = diaryProvider,
        super(key: key);

  final DiaryProvider _diaryProvider;

  Future<void> openDeleteTextModal() async {
    await showModalBottomSheet(
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
            height: 120.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '삭제 하시겠습니까?',
                  style: AppTheme.basicInterTextStyle
                      .copyWith(color: AppTheme.grey500),
                ),
                Contour(
                  color: AppTheme.grey500,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: InkWell(
                    onTap: () {
                      _diaryProvider.textEditingController.clear();
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.transparent,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          CS.YES,
                          style: AppTheme.errorTextStyle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: InkWell(
                      onTap: Navigator.of(context).pop,
                      splashColor: Colors.transparent,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            CS.CANCEL,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: _diaryProvider.reSizedDiaryTextFormField,
            icon: Icon(
              _diaryProvider.isLargeTextForm
                  ? Icons.zoom_in
                  : Icons.zoom_out_map_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: _diaryProvider.textEditingController.text.isNotEmpty
                ? openDeleteTextModal
                : null,
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
    );
  }
}
