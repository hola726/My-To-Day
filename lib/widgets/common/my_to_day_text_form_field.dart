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
    this.suffixIconColor,
    this.onIconPressed,
  });
  final String? hintText;
  final TextStyle? textStyle;
  final double? height;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final void Function()? onIconPressed;

  @override
  _MyToDayTextFormFieldState createState() => _MyToDayTextFormFieldState();
}

class _MyToDayTextFormFieldState extends State<MyToDayTextFormField> {
  final TextEditingController _controller = TextEditingController();

  void handleOnChanged(String value) {
    _controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        controller: _controller,
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
              onPressed: widget.onIconPressed,
              iconSize: 55.w,
              icon: Icon(
                widget.suffixIcon ?? Icons.check_box,
                color: _controller.text.isNotEmpty
                    ? AppTheme.errorColor
                    : widget.suffixIconColor ?? AppTheme.backdropOverlay_65,
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
