import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/utils/date_helper.dart';
import 'package:my_to_day/widgets/common/main_app_bar.dart';
import 'package:my_to_day/widgets/common/my_to_day_text_form_field.dart';

class InitScreen extends StatefulWidget {
  static const id = "/InitScreen";

  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  Widget _buildMain() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          MyToDayTextFormField(
            height: 100.h,
            hintText: "오늘은...",
            onIconPressed: () => {},
          ),
          Container(
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
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.zoom_out_map_outlined,
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "MYTODAY",
        bottomShadow: true,
        titleColor: AppTheme.primaryContrastColor,
        backgroundColors: AppTheme.textPrimaryColor,
      ),
      body: _buildMain(),
    );
  }
}
