import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/utils/modal_helper.dart';

import '../../app_theme.dart';
import 'contour.dart';

class DiaryTextFormOption extends StatefulWidget {
  const DiaryTextFormOption({
    Key? key,
    required this.diaryTextFormController,
    required this.reSizedDiaryTextFormField,
    required this.dataProvider,
    required this.context,
    required this.isLargeTextForm,
    bool? this.isEditTextFormOption,
  }) : super(key: key);

  final DataProvider dataProvider;
  final bool? isEditTextFormOption;
  final BuildContext context;
  final TextEditingController diaryTextFormController;
  final Function() reSizedDiaryTextFormField;
  final bool isLargeTextForm;

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
                    onTap: () {
                      widget.diaryTextFormController.clear();
                      widget.dataProvider.tmpDiaryData = null;
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
                widget.dataProvider.getPhoto(widget.isEditTextFormOption),
            icon: Icon(
              Icons.camera_alt_outlined,
              color: widget.dataProvider
                  .setPhotoColor(widget.isEditTextFormOption),
            ),
          ),
          IconButton(
            onPressed: () => widget.dataProvider
                .getPickerImages(widget.isEditTextFormOption),
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: widget.dataProvider
                  .setPickerImageColor(widget.isEditTextFormOption),
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
            onPressed: widget.reSizedDiaryTextFormField,
            icon: Icon(
              widget.isLargeTextForm
                  ? Icons.zoom_in
                  : Icons.zoom_out_map_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: widget.dataProvider.tmpDiaryData != null
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
              DateHelper.convertDate(_nowTime),
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
