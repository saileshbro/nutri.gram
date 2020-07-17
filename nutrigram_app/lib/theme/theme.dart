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
  appBarTheme: AppBarTheme(
    color: kPrimaryDarkTextColor,
    elevation: 0.0,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(
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
    textStyle: _darkThemeData.textTheme.subtitle,
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
    display1: _darkThemeData.textTheme.display1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 96,
      fontWeight: FontWeight.w300,
    ),
    display2: _darkThemeData.textTheme.display2.copyWith(
      fontFamily: kFontFamily,
      fontSize: 60,
      fontWeight: FontWeight.w600,
    ),
    display3: _darkThemeData.textTheme.display3.copyWith(
      fontFamily: kFontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: kTextFieldBackgroundColor,
    ),
    display4: _darkThemeData.textTheme.display4.copyWith(
      fontFamily: kFontFamily,
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: kTextFieldBackgroundColor,
    ),
    body1: _darkThemeData.textTheme.body1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: kPrimaryDarkTextColor,
    ),
    body2: _darkThemeData.textTheme.body2.copyWith(
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
    subtitle: _darkThemeData.textTheme.subtitle.copyWith(
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
    textStyle: _lightThemeData.textTheme.subtitle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  cardColor: kTextFieldBackgroundColor,
  accentColor: kPrimaryColor,
  cursorColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    color: kScaffoldBackgroundColor,
    elevation: 0.0,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  primaryColor: kPrimaryColor,
  fontFamily: kFontFamily,
  primaryIconTheme: IconThemeData(
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
    display1: _lightThemeData.textTheme.display1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 96,
      fontWeight: FontWeight.w300,
    ),
    display2: _lightThemeData.textTheme.display2.copyWith(
      fontFamily: kFontFamily,
      fontSize: 60,
      fontWeight: FontWeight.w600,
    ),
    display3: _lightThemeData.textTheme.display3.copyWith(
      fontFamily: kFontFamily,
      fontSize: 20,
      color: kPrimaryMediumTextColor,
      fontWeight: FontWeight.w500,
    ),
    subtitle: _lightThemeData.textTheme.subtitle.copyWith(
      fontFamily: kFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    display4: _lightThemeData.textTheme.display4.copyWith(
      fontFamily: kFontFamily,
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: kPrimaryDarkTextColor,
    ),
    body1: _lightThemeData.textTheme.body1.copyWith(
      fontFamily: kFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: kPrimaryDarkTextColor,
    ),
    body2: _lightThemeData.textTheme.body2.copyWith(
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
