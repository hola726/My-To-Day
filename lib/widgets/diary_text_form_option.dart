import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:my_to_day/provider/diary_provider.dart';
import 'package:my_to_day/utils/date_helper.dart';

import '../app_theme.dart';

class DiaryTextFormOption extends StatelessWidget {
  const DiaryTextFormOption({
    Key? key,
    required DiaryProvider diaryProvider,
  })  : _diaryProvider = diaryProvider,
        super(key: key);

  final DiaryProvider _diaryProvider;

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
            onPressed: () => {},
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
