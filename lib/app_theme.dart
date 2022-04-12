import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/utils/foundatioin.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryMainColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryMainColor,
      indicatorColor: Colors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      errorColor: primaryMainColor,
      iconTheme: IconThemeData(
        color: primaryMainColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryMainColor,
        foregroundColor: Colors.white,
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      platform: isIos ? TargetPlatform.iOS : TargetPlatform.android,
    );
  }

  static final brandTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 15.0.sp,
    color: primaryMainColor,
  );

  static final primaryMainTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 18.0.sp,
    color: primaryColor,
  );

  static final secondaryMainTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 14.0.sp,
    color: primaryMainColor,
  );

  static final checkBoxTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14.0.sp,
    color: primaryMainColor,
  );
  static final helpServiceBundleTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 12.0.sp,
    color: primaryMainColor,
  );

  static final tertiaryMainTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 15.0.sp,
    color: tertiaryMainColor,
  );

  static final whiteTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 15.0.sp,
    color: Colors.white,
  );

  static final robotoTextStyle = TextStyle(
    fontFamily: Roboto,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 15.0.sp,
    color: textPrimaryColor,
  );

  static final notoSansKRTextStyle = TextStyle(
    fontFamily: NotoSansKR,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 15.0.sp,
    color: textPrimaryColor,
  );

  static final headerTextStyle = TextStyle(
    fontFamily: NotoSansKR,
    fontWeight: FontWeight.w600,
    fontSize: 16.0.sp,
    color: primaryMainColor,
  );

  static final inactiveTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    color: inactiveColor,
    fontWeight: FontWeight.w600,
    fontSize: 10.0.sp,
  );

  static final dialogContentTextStyle = TextStyle(
    fontFamily: AppleSDGothicNeo,
    color: secondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 14.0.sp,
  );

  static final approveTextStyle = TextStyle(
    color: const Color(0xff807675),
    fontWeight: FontWeight.w400,
    fontFamily: AppleSDGothicNeo,
    fontStyle: FontStyle.normal,
    fontSize: 13.0.sp,
  );
  static final blastingMainTextStyle = TextStyle(
    fontFamily: Arial,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14.0.sp,
    color: primaryMainColor,
  );
  static final blastingMainBoldTextStyle = TextStyle(
    fontFamily: Arial,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 14.0.sp,
    color: primaryMainColor,
  );

  static final blastingTitleTextStyle = TextStyle(
    fontFamily: Arial,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 18.0.sp,
    color: primaryMainColor,
  );

  static final errorTextStyle = brandTextStyle.copyWith(
    fontSize: 13.sp,
    color: errorColor,
  );

  static final basicInterTextStyle = TextStyle(
    fontFamily: Inter,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14.0.sp,
  );

  static final headline1 = TextStyle(
    fontFamily: Roboto,
    fontSize: 96.sp,
    letterSpacing: -1.5.sp,
    fontWeight: FontWeight.w300,
  );
  static final headline2 = TextStyle(
    fontFamily: Roboto,
    fontSize: 60.sp,
    letterSpacing: -0.5.sp,
    fontWeight: FontWeight.w300,
  );
  static final headline3 = TextStyle(
    fontFamily: Roboto,
    fontSize: 48.sp,
    letterSpacing: 0.sp,
    fontWeight: FontWeight.w400,
  );
  static final headline4 = TextStyle(
    fontFamily: Roboto,
    fontSize: 34.sp,
    letterSpacing: 0.25.sp,
    fontWeight: FontWeight.w400,
  );
  static final headline4_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 34.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25.sp,
  );
  static final headline5 = TextStyle(
    fontFamily: Roboto,
    fontSize: 24.sp,
    letterSpacing: 0.sp,
    fontWeight: FontWeight.w400,
  );
  static final headline5_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 24.sp,
    letterSpacing: 0.sp,
    fontWeight: FontWeight.w700,
  );
  static final headline6 = TextStyle(
    fontFamily: Roboto,
    fontSize: 20.sp,
    letterSpacing: 0.15.sp,
    fontWeight: FontWeight.w500,
  );
  static final headline6_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15.sp,
  );
  static final headline7_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.sp,
  );
  static final subtitle1 = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15.sp,
  );
  static final subtitle1_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15.sp,
  );
  static final subtitle2 = TextStyle(
    fontFamily: Roboto,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1.sp,
  );
  static final subtitle2_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1.sp,
  );
  static final body1 = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.sp,
  );
  static final body2 = TextStyle(
    fontFamily: Roboto,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15.sp,
  );
  static final body3 = TextStyle(
    fontFamily: Roboto,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.sp,
  );
  static final overline = TextStyle(
    fontFamily: Roboto,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.sp,
  );
  static final caption = TextStyle(
    fontFamily: Roboto,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
  );

  static final button_large = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.46.sp,
  );
  static final button_large_bold = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.46.sp,
  );
  static final button_medium = TextStyle(
    fontFamily: Roboto,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4.sp,
  );
  static final button_small = TextStyle(
    fontFamily: Roboto,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.46.sp,
  );
  static final input_label = TextStyle(
    fontFamily: Roboto,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15.sp,
  );
  static final helper_text = TextStyle(
    fontFamily: Roboto,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
  );
  static final input_text = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15.sp,
  );
  static final avatar_initials = TextStyle(
    fontFamily: Roboto,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14.sp,
  );
  static final chip = TextStyle(
    fontFamily: Roboto,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.16.sp,
  );
  static final tooltip = TextStyle(
    fontFamily: Roboto,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.sp,
  );
  static final alert_title = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15.sp,
  );
  static final table_header = TextStyle(
    fontFamily: Roboto,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.17.sp,
  );
  static final badge_label = TextStyle(
    fontFamily: Roboto,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.14.sp,
  );

  static final headline1_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 96.sp,
    letterSpacing: -1.5.sp,
    fontWeight: FontWeight.w300,
  );
  static final headline2_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 60.sp,
    letterSpacing: -0.5.sp,
    fontWeight: FontWeight.w300,
  );
  static final headline3_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 48.sp,
    letterSpacing: 0.sp,
    fontWeight: FontWeight.w400,
  );
  static final headline4_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 34.sp,
    letterSpacing: 0.25.sp,
    fontWeight: FontWeight.w400,
  );
  static final headline4_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 34.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25.sp,
  );
  static final headline5_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 24.sp,
    letterSpacing: 0.sp,
    fontWeight: FontWeight.w400,
  );
  static final headline5_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 24.sp,
    letterSpacing: 0.sp,
    fontWeight: FontWeight.w700,
  );
  static final headline6_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 20.sp,
    letterSpacing: 0.15.sp,
    fontWeight: FontWeight.w500,
  );
  static final headline6_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15.sp,
  );
  static final headline7_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.sp,
  );
  static final headline7_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.sp,
  );
  static final subtitle1_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15.sp,
  );
  static final subtitle1_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15.sp,
  );
  static final subtitle2_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1.sp,
  );
  static final subtitle2_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1.sp,
  );
  static final body1_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.sp,
  );
  static final body2_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15.sp,
  );
  static final body3_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.sp,
  );
  static final overline_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.sp,
  );
  static final caption_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
  );

  static final button_large_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.46.sp,
  );
  static final button_large_bold_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.46.sp,
  );
  static final button_medium_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4.sp,
  );
  static final button_small_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.46.sp,
  );
  static final input_label_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15.sp,
  );
  static final helper_text_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
  );
  static final input_text_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15.sp,
  );
  static final avatar_initials_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14.sp,
  );
  static final chip_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.16.sp,
  );
  static final tooltip_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.sp,
  );
  static final alert_title_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15.sp,
  );
  static final table_header_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.17.sp,
  );
  static final badge_label_KR = TextStyle(
    fontFamily: NotoSansKR,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.14.sp,
  );

  static const AppleSDGothicNeo = 'AppleSDGothicNeo';
  static const SFUIDisplay = 'SFUIDisplay';
  static const SFProDisplay = 'SFProDisplay';
  static const SFProText = 'SFProText';
  static const Inter = 'Inter';
  static const Arial = 'Arial';
  static const Roboto = 'Roboto';
  static const NotoSansKR = 'NotoSansKR';

  static const lightColor = Color(0x99000000);
  static const taskFinishedColor = Color(0xfff5f8fe);
  static const taskPreparationColor = Color(0xffe0e0e0);
  static const barrierColor = Color(0x80182061);
  static const primaryColor = Color(0xff383536);
  static const secondaryColor = Color(0xff807675);
  static const tertiaryMainColor = Color(0xffada6a6);
  static const inactiveColor = Color(0xffd1cbca);
  static const lineColor = Color(0x4d433c3c);
  static const graphLineColor = Color(0xffe7e7e7);
  static const tableBackgroundColor = Color(0xfff3f1f1);
  static const tableBoxShadowColor = Color(0x4dcebcbc);
  static const secondaryButtonColor = Color(0x99fde5e3);
  static const graphMaxColor = Color(0xffff9900);
  static const primaryGraphColor = Color(0xfff1bfbf);
  static const secondaryGraphColor = Color(0xffe68988);
  static const averageColor = Color(0xff5c72e3);
  static const loginBoxColor = Color(0xffaea3a2);
  static const contourSecondColor = Color(0xff182061);
  static const errorColor = Color(0xffFC4646);
  static const passColor = Color(0xff1A9D2F);
  static const outRangeColor = Color(0xff941250);

  static const primaryMainColor = Color(0xff182061);
  static const primaryLightColor = Color(0xff49468E);
  static const primaryDarkColor = Color(0xff000036);
  static const primaryContrastColor = Color(0xffFFFFFF);
  static const primaryContainedHoverBackgroundColor = Color(0xff000040);
  static const primaryOutlinedHoverBackgroundColor = Color(0xffEDEDF2);
  static const primaryOutlinedRestingBackgroundColor = Color(0xff8B8FB0);

  static const secondaryMainColor = Color(0xffE9F1FD);
  static const secondaryLightColor = Color(0xffF5F8FE);
  static const secondaryDarkColor = Color(0xffD4E4FE);
  static const secondaryContrastColor = Color(0xff182061);
  static const secondaryContrast2Color = Color(0xff4E78B5);
  static const secondaryContainedHoverBackgroundColor = Color(0xffD4E5FF);
  static const secondaryOutlinedHoverBackgroundColor = Color(0xffE6F0FF);
  static const secondaryOutlinedRestingBackgroundColor = Color(0xffB7D3FF);

  static const textPrimaryColor = Color(0xff191919);
  static const textPrimary2Color = Color(0xff182061);
  static const textSecondaryColor = Color(0xff666666);
  static const textSecondary2Color = Color(0xff424242);
  static const textDisabledColor = Color(0xff9E9E9E);

  static const actionActiveColor = Color(0xff757575);
  static const actionHoverColor = Color(0xffF5F5F5);
  static const actionSelectedColor = Color(0xffEBEBEB);
  static const actionDisabledColor = Color(0xffBDBDBD);
  static const actionDisabledBackgroundColor = Color(0xffE0E0E0);

  static const actionFocusColor = Color(0xffE0E0E0);

  static const errorMainColor = Color(0xffC5292A);
  static const errorDarkColor = Color(0xffE31B0C);
  static const errorLightColor = Color(0xffF88078);
  static const errorContrastColor = Color(0xffFFFFFF);
  static const errorContainedHoverBackgroundColor = Color(0xffAB2F26);
  static const errorOutlinedHoverBackgroundColor = Color(0xffFEF0EF);
  static const errorOutlinedRestingBorderColor = Color(0xffD15455);
  static const errorContentColor = Color(0xff621B16);
  static const errorBackgroundColor = Color(0xffFEECEB);

  static const warningMainColor = Color(0xffFFD965);
  static const warningDarkColor = Color(0xffC77700);
  static const warningLightColor = Color(0xffFFB547);
  static const warningContrastColor = Color(0xffFFFFFF);
  static const warningContainedHoverColor = Color(0xffA64C01);
  static const warningOutlinedRestingBorderColor = Color(0xffF6B580);
  static const warningOutlinedHoverBackgroundColor = Color(0xffFEF3EB);
  static const warningContentColor = Color(0xff5F2B01);
  static const warningBackgroundColor = Color(0xffFDF0E6);

  static const successMainColor = Color(0xff419FA8);
  static const successDarkColor = Color(0xff007079);
  static const successLightColor = Color(0xff76D0D9);
  static const successContrastColor = Color(0xffFFFFFF);
  static const successContainedHoverBackgroundColor = Color(0xff2E6F76);
  static const successOutlinedRestingBorderColor = Color(0xffA0CFD3);
  static const successOutlinedHoverBackgroundColor = Color(0xffF0F7F8);
  static const successContentColor = Color(0xff1A4043);
  static const successBackgroundColor = Color(0xffECF5F6);

  static const backgroundPaperColor = Color(0xffFFFFFF);
  static const backgroundDefaultColor = Color(0xffFAFAFA);

  static const dividerColor = Color(0xffE0E0E0);
  static const outlinedBorderColor = Color(0xffC4C4C4);
  static const backdropOverlay_65 = Color(0xff595959);
  static const backdropOverlay_40 = Color(0xff999999);
  static const filledInputBackgroundColor = Color(0xffE8E8E8);
  static const standardInputLineColor = Color(0xff949494);
  static const snackbarColor = Color(0xff323232);
  static const ratingActiveColor = Color(0xffFFB400);
  static const commonBlack = Color(0xff191919);
  static const commonWhite = Color(0xffFFFFFF);
  static const grey100 = Color(0xffF5F5F5);
  static const grey200 = Color(0xffEEEEEE);
  static const grey300 = Color(0xffE0E0E0);
  static const grey400 = Color(0xffBDBDBD);
  static const grey500 = Color(0xff9E9E9E);
  static const grey600 = Color(0xff757575);
  static const grey800 = Color(0xff424242);
}
