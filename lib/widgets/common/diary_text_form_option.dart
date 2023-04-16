import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/utils/modal_helper.dart';

import '../../app_theme.dart';
import '../../model/data/diary_data.dart';
import 'contour.dart';

class DiaryTextFormOption extends StatefulWidget {
  const DiaryTextFormOption({
    Key? key,
    required this.diaryTextFormController,
    required this.reSizedDiaryTextFormField,
    required this.context,
    required this.isLargeTextForm,
    required this.diaryData,
    required this.onCameraPressed,
    required this.onImagesPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  final BuildContext context;
  final TextEditingController diaryTextFormController;
  final Function() reSizedDiaryTextFormField;
  final bool isLargeTextForm;
  final Function() onCameraPressed;
  final Function() onImagesPressed;
  final Function() onDeletePressed;
  final DiaryData? diaryData;

  @override
  State createState() => _DiaryTextFormOptionState();
}

class _DiaryTextFormOptionState extends State<DiaryTextFormOption> {
  DateTime _nowTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              _nowTime = DateTime.now();
            }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> openDeleteTextModal() async {
    await showModalBottomSheet(
        context: widget.context,
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
                    onTap: widget.onDeletePressed,
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
            onPressed: widget.onCameraPressed,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.camera_alt_outlined,
              color: widget.diaryData?.cameraImage != null
                  ? Colors.red
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: widget.onImagesPressed,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: widget.diaryData?.pickerImages != null
                  ? Colors.red
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => ModalHelper.openMapsModal(context: context),
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: widget.reSizedDiaryTextFormField,
            constraints: const BoxConstraints(),
            icon: Icon(
              widget.isLargeTextForm
                  ? Icons.zoom_in
                  : Icons.zoom_out_map_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: widget.diaryData != null ? openDeleteTextModal : null,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.restore_from_trash_outlined,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () => {},
            child: Text(
              DateHelper.convertDate(_nowTime),
              style: AppTheme.subtitle1.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
