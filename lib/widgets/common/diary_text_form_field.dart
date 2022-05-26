import 'dart:io';

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
    if (widget.initialText != null) {
      widget.controller.text = widget.initialText!;
      setState(() {});
    }
  }

  SizedBox buildTextFormField() {
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
            suffixIcon: widget.isDisableIcon == true ? null : widget.suffixIcon,
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

  bool isImageTextFormField() {
    return widget.initialImage != null &&
        widget.diaryProvider.isLargeTextForm == true;
  }

  @override
  Widget build(BuildContext context) {
    return isImageTextFormField()
        ? Column(
            children: [
              buildTextFormField(),
              Row(
                children: [
                  Container(
                    child: Image.file(
                      File(widget.initialImage.path),
                      height: 50.h,
                      width: 50.w,
                    ),
                  )
                ],
              ),
            ],
          )
        : buildTextFormField();
  }
}
