import 'package:flutter/material.dart';
import "../../utils/utils.dart";

class AppThemes {

  static const Color _lightPrimaryColor = Color.fromRGBO(105,157,234,1);
  static const Color _primaryColor = Color.fromRGBO(34,112,230,1);
  static const Color _darkPrimaryColor = Color.fromRGBO(15,50,102,1);
  static const Color _lightOnPrimaryColor = Colors.white;

  static const _lightSecondaryColor = Color.fromRGBO(198,234,82,1);
  static const _secondaryColor = Color.fromRGBO(179,230,11,1);
  static const _darkSecondaryColor = Color.fromRGBO(118,153,4,1);

  static const _lightAppBarColor = _primaryColor;
  static const Color _lightButtonPrimaryColor = _secondaryColor;
  static const Color _lightSnackBarBackgroundColor = Colors.white;
  static const Color _lightIconColor = _lightPrimaryColor;


  //text theme for light theme
  static final TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskNameTextStyle =
      TextStyle(fontSize: 16.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskDurationTextStyle =
      TextStyle(fontSize: 14.0, color: Colors.grey);
  static final TextStyle _lightScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _lightOnPrimaryColor, fontWeight: FontWeight.w500);
  static final TextStyle _lightScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0, color: _lightAppBarColor, fontWeight: FontWeight.w100);

  static final TextTheme _lightTextTheme = TextTheme(
    headline5: _lightScreenHeadingTextStyle,
    bodyText1: _lightScreenTaskNameTextStyle,
    bodyText2: _lightScreenTaskDurationTextStyle,
    button: _lightScreenButtonTextStyle,
    headline6: _lightScreenTaskNameTextStyle,
    subtitle2: _lightScreenTaskNameTextStyle,
    caption: _lightScreenCaptionTextStyle,
  );


  static final ThemeData lightTheme = ThemeData(
    fontFamily: "ProductSans",
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightButtonPrimaryColor),
    appBarTheme: AppBarTheme(
      color: _lightAppBarColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      textTheme: _lightTextTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _secondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    primaryColor: _primaryColor,
    primaryColorLight: _lightPrimaryColor,
    primaryColorDark: _darkPrimaryColor,
    primarySwatch: createMaterialColor(_primaryColor),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _lightSnackBarBackgroundColor
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: _lightAppBarColor
    ),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _lightTextTheme,
    
  );
  
}