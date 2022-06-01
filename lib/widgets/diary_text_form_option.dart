import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_to_day/constants/constant_strings.dart' as CS;
import 'package:my_to_day/model/data/diary_data.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';

import '../app_theme.dart';
import 'common/contour.dart';

class DiaryTextFormOption extends StatelessWidget {
  const DiaryTextFormOption({
    Key? key,
    required DiaryProvider diaryProvider,
    required DataProvider dataProvider,
    bool? isEditTextFormOption,
  })  : _isEdit = isEditTextFormOption,
        _diaryProvider = diaryProvider,
        _dataProvider = dataProvider,
        super(key: key);

  final DiaryProvider _diaryProvider;
  final DataProvider _dataProvider;
  final bool? _isEdit;

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
                      _diaryProvider.diaryTextFormController.clear();
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

  void setPhoto(XFile? photo) {
    if (_dataProvider.tmpDiaryData != null) {
      _dataProvider.tmpDiaryData = _dataProvider.tmpDiaryData!.copyWith(
        cameraImage: photo,
      );
    } else {
      _dataProvider.tmpDiaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        cameraImage: photo,
      );
    }
  }

  void editPhoto(XFile? photo) {
    if (_dataProvider.diaryData != null) {
      _dataProvider.diaryData = _dataProvider.diaryData!.copyWith(
        cameraImage: photo,
      );
    }
  }

  void setPickerImages(List<XFile>? images) {
    if (_dataProvider.tmpDiaryData != null) {
      _dataProvider.tmpDiaryData = _dataProvider.tmpDiaryData!.copyWith(
        pickerImages: images,
      );
    } else {
      _dataProvider.tmpDiaryData = DiaryData(
        contents: '',
        time: DateTime.now(),
        pickerImages: images,
      );
    }
  }

  void editPickerImages(List<XFile>? images) {
    if (_dataProvider.diaryData != null) {
      _dataProvider.diaryData = _dataProvider.diaryData!.copyWith(
        pickerImages: images,
      );
    }
  }

  Color setPhotoColor() {
    return _isEdit == true
        ? _dataProvider.diaryData?.cameraImage != null
            ? Colors.red
            : Colors.white
        : _dataProvider.tmpDiaryData?.cameraImage != null
            ? Colors.red
            : Colors.white;
  }

  Color setPickerImageColor() {
    return _isEdit == true
        ? _dataProvider.diaryData?.pickerImages != null
            ? Colors.red
            : Colors.white
        : _dataProvider.tmpDiaryData?.pickerImages != null
            ? Colors.red
            : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.commonBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              if (_isEdit == true) {
                editPhoto(photo);
              } else {
                setPhoto(photo);
              }
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              color: setPhotoColor(),
            ),
          ),
          IconButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final List<XFile>? images = await _picker.pickMultiImage();

              if (_isEdit == true) {
                editPickerImages(images);
              } else {
                setPickerImages(images);
              }
            },
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: setPickerImageColor(),
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
            onPressed: _diaryProvider.diaryTextFormController.text.isNotEmpty
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
