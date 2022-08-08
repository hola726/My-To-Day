import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/utils/modal_helper.dart';

import '../../app_theme.dart';
import 'contour.dart';

class DiaryTextFormOption extends StatefulWidget {
  const DiaryTextFormOption({
    Key? key,
    required DiaryProvider diaryProvider,
    required DataProvider dataProvider,
    bool? isEditTextFormOption,
  })  : _isEditTextFormOption = isEditTextFormOption,
        _diaryProvider = diaryProvider,
        _dataProvider = dataProvider,
        super(key: key);

  final DiaryProvider _diaryProvider;
  final DataProvider _dataProvider;
  final bool? _isEditTextFormOption;

  @override
  State createState() => _DiaryTextFormOptionState();
}

class _DiaryTextFormOptionState extends State<DiaryTextFormOption> {
  DateTime nowTime = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              nowTime = DateTime.now();
            }));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> openDeleteTextModal() async {
    await showModalBottomSheet(
        context: widget._diaryProvider.context,
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
                      widget._diaryProvider.diaryTextFormController.clear();
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
            onPressed: () =>
                widget._dataProvider.getPhoto(widget._isEditTextFormOption),
            icon: Icon(
              Icons.camera_alt_outlined,
              color: widget._dataProvider
                  .setPhotoColor(widget._isEditTextFormOption),
            ),
          ),
          IconButton(
            onPressed: () => widget._dataProvider
                .getPickerImages(widget._isEditTextFormOption),
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: widget._dataProvider
                  .setPickerImageColor(widget._isEditTextFormOption),
            ),
          ),
          IconButton(
            onPressed: () => ModalHelper.openMapsModal(context: context),
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: widget._diaryProvider.reSizedDiaryTextFormField,
            icon: Icon(
              widget._diaryProvider.isLargeTextForm
                  ? Icons.zoom_in
                  : Icons.zoom_out_map_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed:
                widget._diaryProvider.diaryTextFormController.text.isNotEmpty
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
              DateHelper.convertDate(nowTime),
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
