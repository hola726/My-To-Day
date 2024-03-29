import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/constants/constants.dart';

import '../../app_theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    this.leading,
    this.isShowBackButton,
    this.title,
    this.titleTextStyle,
    this.isKRTitle,
    this.backgroundColors,
    this.bottomShadow,
    this.titleColor,
    this.rightTopWidget,
    this.appBarWidgets,
    this.leadingWidth,
  })  : preferredSize = const Size.fromHeight(kAppBarSize),
        super(key: key);

  @override
  final Size preferredSize;
  final Widget? leading;
  final bool? isShowBackButton;
  final bool? isKRTitle;
  final bool? bottomShadow;
  final String? title;

  final TextStyle? titleTextStyle;
  final Color? backgroundColors;
  final Color? titleColor;
  final Widget? rightTopWidget;
  final List<Widget>? appBarWidgets;
  final double? leadingWidth;
  @override
  Widget build(BuildContext context) {
    final NavigatorState _navigatorState = Navigator.of(context);
    return AppBar(
      centerTitle: true,
      leading: leading ??
          (_navigatorState.canPop() && isShowBackButton == true
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24.w,
                  ),
                )
              : null),
      actions: rightTopWidget != null
          ? [
              rightTopWidget!,
              SizedBox(
                width: 16.w,
              ),
            ]
          : appBarWidgets,
      leadingWidth: leadingWidth,
      title: title == null
          ? null
          : Text(
              title!,
              style: titleTextStyle ??
                  (isKRTitle == true
                      ? AppTheme.subtitle1_KR.copyWith(
                          color: titleColor ?? AppTheme.textPrimaryColor,
                        )
                      : AppTheme.subtitle1.copyWith(
                          color: titleColor ?? AppTheme.textPrimaryColor,
                        )),
              textAlign: TextAlign.start,
            ),
      backgroundColor: backgroundColors ??
          (bottomShadow == true ? Colors.white : Colors.transparent),
      toolbarHeight: kAppBarSize.h,
      bottomOpacity: bottomShadow == true ? 1.0 : 0.0,
      toolbarOpacity: 1.0,
      elevation: bottomShadow == true ? 4.0 : 0.0,
    );
  }
}
