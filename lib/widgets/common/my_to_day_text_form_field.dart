import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:my_to_day/app_theme.dart';

class MyToDayTextFormField extends StatefulWidget {
  MyToDayTextFormField({
    this.hintText,
    this.textStyle,
    this.height,
    this.suffixIcon,
  });
  final String? hintText;
  final TextStyle? textStyle;
  final double? height;
  final Widget? suffixIcon;

  @override
  _MyToDayTextFormFieldState createState() => _MyToDayTextFormFieldState();
}

class _MyToDayTextFormFieldState extends State<MyToDayTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        expands: true,
        maxLines: null,
        style: widget.textStyle ??
            AppTheme.subtitle1.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: widget.suffixIcon,
            contentPadding: EdgeInsets.all(
              10.w,
            ),
            hintText: widget.hintText,
            hintStyle: AppTheme.subtitle1.copyWith(
              fontSize: 12.sp,
              color: AppTheme.textDisabledColor,
            )),
      ),
    );
  }
}
