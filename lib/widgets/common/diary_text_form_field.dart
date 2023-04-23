import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/app_theme.dart';
import 'package:path_provider/path_provider.dart';

class DiaryTextFormField extends StatefulWidget {
  const DiaryTextFormField({
    Key? key,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.height,
    this.suffixIcon,
    this.textFocusNode,
    this.isDisableIcon,
    this.initialText,
    this.initialImage,
    this.initialPickerImages,
    this.isLargeTextForm,
    this.handleOnChanged,
    this.isEditTextFormOption,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? initialText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? height;
  final Widget? suffixIcon;
  final FocusNode? textFocusNode;
  final bool? isDisableIcon;
  final void Function(String)? handleOnChanged;
  final String? initialImage;
  final List<String>? initialPickerImages;
  final bool? isEditTextFormOption;
  final bool? isLargeTextForm;

  @override
  _DiaryTextFormFieldState createState() => _DiaryTextFormFieldState();
}

class _DiaryTextFormFieldState extends State<DiaryTextFormField> {
  String _localPath = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.initialText != null) {
      widget.controller.text = widget.initialText!;
    }
    _localPath = (await getApplicationDocumentsDirectory()).path;

    setState(() {});
  }

  SizedBox buildTextFormField() {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        keyboardAppearance: SchedulerBinding.instance.window.platformBrightness,
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
    return (widget.initialImage != null ||
            widget.initialPickerImages != null) &&
        (widget.isLargeTextForm == true || widget.isEditTextFormOption == true);
  }

  @override
  Widget build(BuildContext context) {
    return isImageTextFormField()
        ? Column(
            children: [
              buildTextFormField(),
              Container(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (widget.initialImage != null && _localPath.isNotEmpty)
                        Container(
                          child: Image.file(
                            File("$_localPath/${widget.initialImage!}"),
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                      if (widget.initialPickerImages != null &&
                          _localPath.isNotEmpty)
                        Row(
                          children:
                              widget.initialPickerImages!.map<Widget>((image) {
                            return Container(
                              child: Image.file(
                                File("$_localPath/$image"),
                                height: 50.h,
                                width: 50.w,
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : buildTextFormField();
  }
}
