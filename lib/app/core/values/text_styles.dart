import 'package:audio_youtube/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

import '/app/core/values/app_colors.dart';

extension CoppyWithFontSize on TextStyle {
  TextStyle get s10 => copyWith(fontSize: 10);
  TextStyle get s12 => copyWith(fontSize: 12);
  TextStyle get s14 => copyWith(fontSize: 14);
  TextStyle get s16 => copyWith(fontSize: 16);
  TextStyle get s18 => copyWith(fontSize: 18);
  TextStyle get s20 => copyWith(fontSize: 20);
  TextStyle get s22 => copyWith(fontSize: 22);
}

const centerTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: AppColors.centerTextColor,
);

const errorTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: AppColors.errorColor,
);

const greyDarkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textColorGreyDark,
    height: 1.45);

const primaryColorSubtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.colorPrimary,
    height: 1.45);

const whiteText16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const whiteText18 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const whiteText32 = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const cyanText16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.textColorCyan,
);

const cyanText32 = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w400,
  color: AppColors.textColorCyan,
);

const dialogSubtitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.textColorPrimary,
);

const labelStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  height: 1.8,
);

final labelStylePrimaryTextColor = labelStyle.copyWith(
  color: AppColors.textColorPrimary,
  height: 1,
);

final labelStyleAppPrimaryColor = labelStyle.copyWith(
  color: AppColors.colorPrimary,
  height: 1,
);

final labelStyleGrey =
    labelStyle.copyWith(color: const Color(0xFF323232).withOpacity(0.5));

final labelCyanStyle = labelStyle.copyWith(color: AppColors.textColorCyan);

const labelStyleWhite = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  height: 1.8,
  color: Colors.white,
);

const appBarSubtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.colorWhite);

const cardTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.textColorPrimary);

const cardTitleCyanStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: AppColors.colorPrimary,
);

const cardSubtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.textColorGreyLight);

const titleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  height: 1.34,
);

const settingsItemStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

final cardTagStyle = titleStyle.copyWith(color: AppColors.textColorGreyDark);

const titleStyleWhite = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.colorWhite);

const inputFieldLabelStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  height: 1.34,
  color: AppColors.textColorPrimary,
);

const cardSmallTagStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.textColorGreyDark);

const pageTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.15,
    color: AppColors.appBarTextColor);

final pageTitleBlackStyle =
    pageTitleStyle.copyWith(color: AppColors.textColorPrimary);

const appBarActionTextStyle = TextStyle(
  fontFamily: FontFamily.afacad,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: AppColors.colorPrimary,
);

const pageTitleWhiteStyle = TextStyle(
    fontFamily: FontFamily.afacad,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.15,
    color: AppColors.colorWhite);

const extraBigTitleStyle = TextStyle(
  fontFamily: FontFamily.afacad,
  fontSize: 40,
  fontWeight: FontWeight.w600,
  height: 1.12,
);

final extraBigTitleCyanStyle =
    extraBigTitleStyle.copyWith(color: AppColors.textColorCyan);

const bigTitleStyle = TextStyle(
  fontFamily: FontFamily.afacad,
  fontSize: 28,
  fontWeight: FontWeight.w700,
  height: 1.15,
);

const mediumTitleStyle = TextStyle(
  fontFamily: FontFamily.afacad,
  fontSize: 24,
  fontWeight: FontWeight.w500,
  height: 1.15,
);

const descriptionTextStyle = TextStyle(
  fontSize: 16,
);

final bigTitleCyanStyle =
    bigTitleStyle.copyWith(color: AppColors.textColorCyan);

const bigTitleWhiteStyle = TextStyle(
  fontFamily: FontFamily.afacad,
  fontSize: 28,
  fontWeight: FontWeight.w700,
  height: 1.15,
  color: Colors.white,
);

const boldTitleStyle = TextStyle(
  fontFamily: FontFamily.afacad,
  fontSize: 18,
  fontWeight: FontWeight.w700,
  height: 1.34,
);
final boldTitleWhiteStyle =
    boldTitleStyle.copyWith(color: AppColors.textColorWhite);

final boldTitleCyanStyle =
    boldTitleStyle.copyWith(color: AppColors.textColorCyan);

final boldTitleSecondaryColorStyle =
    boldTitleStyle.copyWith(color: AppColors.textColorSecondary);

final boldTitlePrimaryColorStyle =
    boldTitleStyle.copyWith(color: AppColors.colorPrimary);

const afaca = TextStyle(
  fontFamily: FontFamily.afacad,
);

final TextStyle headerStyle =
    afaca.copyWith(fontSize: 16, fontWeight: FontWeight.w700);
final TextStyle textStyle = afaca.copyWith(
  fontSize: 12,
);
final TextStyle textButtonStyle =
    afaca.copyWith(fontSize: 12, fontWeight: FontWeight.w500);

final TextStyle fontStyteLoadMore =
    afaca.copyWith(color: Colors.blue, fontSize: 12);
