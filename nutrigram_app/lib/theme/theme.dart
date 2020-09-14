import 'package:flutter/material.dart';
import 'package:nutrigram_app/constants/constants.dart';

final ThemeData _lightThemeData = ThemeData.light();
final ThemeData _darkThemeData = ThemeData.dark();
final ThemeData kDarkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  accentColor: kPrimaryColor,
  cursorColor: kPrimaryColor,
  cardColor: kPrimaryMediumTextColor,
  appBarTheme: const AppBarTheme(
    color: kPrimaryDarkTextColor,
    elevation: 0.0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: kTextFieldBackgroundColor,
    ),
  ),
  scaffoldBackgroundColor: kPrimaryDarkTextColor,
  primaryIconTheme: const IconThemeData(color: kTextFieldBackgroundColor),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: kPrimaryMediumTextColor,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    textStyle: _darkThemeData.textTheme.subtitle1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  bottomAppBarColor: Colors.black,
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    textTheme: ButtonTextTheme.primary,
    height: 48,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textTheme: TextTheme(
    headline1: _darkThemeData.textTheme.headline1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 96,
      fontWeight: FontWeight.w300,
    ),
    headline2: _darkThemeData.textTheme.headline2.copyWith(
      fontFamily: kFontFamily,
      fontSize: 60,
      fontWeight: FontWeight.w600,
    ),
    headline3: _darkThemeData.textTheme.headline3.copyWith(
      fontFamily: kFontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: kTextFieldBackgroundColor,
    ),
    headline4: _darkThemeData.textTheme.headline4.copyWith(
      fontFamily: kFontFamily,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: kTextFieldBackgroundColor,
    ),
    bodyText1: _darkThemeData.textTheme.bodyText1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: kPrimaryDarkTextColor,
    ),
    bodyText2: _darkThemeData.textTheme.bodyText2.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: kPrimaryDarkTextColor,
    ),
    button: _darkThemeData.textTheme.button.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kTextFieldBackgroundColor,
    ),
    caption: _darkThemeData.textTheme.caption.copyWith(
      fontFamily: kFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: kTextFieldBackgroundColor,
    ),
    subtitle1: _darkThemeData.textTheme.subtitle1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kTextFieldBackgroundColor,
    ),
  ),
);
final ThemeData kLightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  popupMenuTheme: PopupMenuThemeData(
    textStyle: _lightThemeData.textTheme.subtitle1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  cardColor: kTextFieldBackgroundColor,
  accentColor: kPrimaryColor,
  cursorColor: kPrimaryColor,
  appBarTheme: const AppBarTheme(
    color: kScaffoldBackgroundColor,
    elevation: 0.0,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  primaryColor: kPrimaryColor,
  fontFamily: kFontFamily,
  primaryIconTheme: const IconThemeData(
    color: kDisabledLightThemeColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: kTextFieldBackgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    textTheme: ButtonTextTheme.primary,
    height: 48,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  buttonColor: kPrimaryColor,
  textTheme: TextTheme(
    headline1: _lightThemeData.textTheme.headline1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 96,
      fontWeight: FontWeight.w300,
    ),
    headline2: _lightThemeData.textTheme.headline2.copyWith(
      fontFamily: kFontFamily,
      fontSize: 60,
      fontWeight: FontWeight.w600,
    ),
    headline3: _lightThemeData.textTheme.headline3.copyWith(
      fontFamily: kFontFamily,
      fontSize: 20,
      color: kPrimaryMediumTextColor,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: _lightThemeData.textTheme.subtitle1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    headline4: _lightThemeData.textTheme.headline4.copyWith(
      fontFamily: kFontFamily,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: kPrimaryDarkTextColor,
    ),
    bodyText1: _lightThemeData.textTheme.bodyText1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: kPrimaryDarkTextColor,
    ),
    bodyText2: _lightThemeData.textTheme.bodyText2.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: kPrimaryDarkTextColor,
    ),
    button: _lightThemeData.textTheme.button.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kPrimaryMediumTextColor,
    ),
    caption: _lightThemeData.textTheme.caption.copyWith(
      fontFamily: kFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: kPrimaryLightTextColor,
    ),
  ),
);
