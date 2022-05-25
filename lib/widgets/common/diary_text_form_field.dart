import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:my_to_day/provider/diary_provider.dart';

class DiaryTextFormField extends StatefulWidget {
  const DiaryTextFormField({
    Key? key,
    required this.controller,
    required this.diaryProvider,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.height,
    this.suffixIcon,
    this.onIconPressed,
    this.textFocusNode,
    this.isDisableIcon,
    this.initialText,
    this.initialImage,
    this.handleOnChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? initialText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? height;
  final Widget? suffixIcon;
  final FocusNode? textFocusNode;
  final void Function(String text)? onIconPressed;
  final bool? isDisableIcon;
  final DiaryProvider diaryProvider;
  final void Function(String)? handleOnChanged;
  final dynamic initialImage;

  @override
  _DiaryTextFormFieldState createState() => _DiaryTextFormFieldState();
}

class _DiaryTextFormFieldState extends State<DiaryTextFormField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        focusNode: widget.textFocusNode,
        controller: widget.controller,
        onChanged: widget.handleOnChanged,
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
            hintStyle: widget.hintStyle ??
                AppTheme.subtitle1.copyWith(
                  fontSize: 12.sp,
                  color: AppTheme.textDisabledColor,
                )),
      ),
    );
  }
}
