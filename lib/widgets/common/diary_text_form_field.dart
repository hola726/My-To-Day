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
    this.textStyle,
    this.height,
    this.suffixIcon,
    this.suffixIconColor,
    this.onIconPressed,
    this.textFocusNode,
    this.isDisableIcon,
    this.initialValue,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? initialValue;
  final TextStyle? textStyle;
  final double? height;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final FocusNode? textFocusNode;
  final void Function(String text)? onIconPressed;
  final bool? isDisableIcon;
  final DiaryProvider diaryProvider;

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

  void handleOnChanged(String value) {
    widget.controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    widget.diaryProvider.getChange();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        focusNode: widget.textFocusNode,
        controller: widget.controller,
        onChanged: handleOnChanged,
        expands: true,
        maxLines: null,
        style: widget.textStyle ??
            AppTheme.subtitle1.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              padding: EdgeInsets.all(10.w),
              onPressed: () {
                if (widget.onIconPressed != null) {
                  widget.onIconPressed!(widget.controller.text);
                  widget.controller.clear();
                  setState(() {});
                }
              },
              iconSize: 55.w,
              icon: widget.isDisableIcon == true
                  ? Container()
                  : Icon(
                      widget.suffixIcon ?? Icons.check_box,
                      color: widget.controller.text.isNotEmpty
                          ? AppTheme.errorColor
                          : widget.suffixIconColor ??
                              AppTheme.backdropOverlay_65,
                    ),
            ),
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
