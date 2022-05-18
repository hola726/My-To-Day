import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_theme.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    Key? key,
    this.width,
    this.height,
    required this.onPressed,
    this.text,
    this.textStyle,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.color = AppTheme.primaryMainColor,
    this.disable,
    this.disableBackgroundColor,
    this.disableBorderColor,
    this.hoverColor,
    this.buttonWidget,
    this.boldText,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? text;
  final void Function() onPressed;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color color;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool? disable;
  final Color? hoverColor;
  final Widget? buttonWidget;
  final Color? disableBackgroundColor;
  final Color? disableBorderColor;
  final bool? boldText;

  @override
  State createState() => _MainButton();
}

class _MainButton extends State<MainButton> {
  bool _isHover = false;

  TextStyle _largeText(Color color) {
    return AppTheme.button_large_KR.copyWith(
      color: color,
    );
  }

  TextStyle _smallText(Color color) {
    return AppTheme.button_small_KR.copyWith(
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isHover = false;
        });
        widget.disable == true ? null : widget.onPressed();
      },
      onTapCancel: () => setState(() {
        _isHover = false;
      }),
      onTapDown: (value) {
        setState(() {
          _isHover = true;
        });
      },
      child: Container(
        width: widget.width ?? 156.w,
        height: widget.height ?? 48.h,
        child: Center(
          child: widget.buttonWidget ??
              Text(
                widget.text ?? "",
                textAlign: TextAlign.center,
                style: widget.disable == true
                    ? widget.boldText == true
                        ? _largeText(AppTheme.actionDisabledColor)
                        : _smallText(AppTheme.actionDisabledColor)
                    : widget.textStyle ??
                        (widget.boldText == true
                            ? _largeText(widget.textColor ??
                                AppTheme.primaryContrastColor)
                            : _smallText(widget.textColor ??
                                AppTheme.primaryContrastColor)),
              ),
        ),
        decoration: BoxDecoration(
          color: widget.disable == true
              ? widget.disableBackgroundColor ??
                  AppTheme.actionDisabledBackgroundColor
              : _isHover
                  ? widget.hoverColor ?? widget.color
                  : widget.color,
          border: widget.disable == true
              ? widget.disableBorderColor != null
                  ? Border.all(
                      color: widget.disableBorderColor!,
                      width: 1.w,
                    )
                  : null
              : widget.borderColor != null
                  ? Border.all(
                      color: widget.borderColor!,
                      width: 1.w,
                    )
                  : null,
          borderRadius:
              widget.borderRadius ?? const BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
