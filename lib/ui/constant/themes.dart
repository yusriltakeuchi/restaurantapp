import 'package:flutter/material.dart';
import 'package:restaurantapp/gen/fonts.gen.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

bool isDarkTheme(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

final lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: primaryColor,
  primarySwatch: primaryCustomSwatch,
  brightness: Brightness.light,
  fontFamily: FontFamily.nunitoSans,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.black.withOpacity(0),
  ),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: blackColor,
    displayColor: blackColor,
  ),
  colorScheme: const ColorScheme.light()
      .copyWith(
        primary: primaryColor,
        onPrimary: primaryColor,
      )
      .copyWith(
        primary: primaryColor,
        secondary: primaryColor,
        brightness: Brightness.light,
      ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor,
  ),
);
