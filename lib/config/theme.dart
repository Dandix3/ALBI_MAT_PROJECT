import 'package:flutter/material.dart';
import 'package:albi_hry/config/colors.dart';


ThemeData albi_theme = ThemeData.dark()
    .copyWith( // možná appbar hodit průhledy jak HBO appka
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AlbiColors.primaryColorBlue,
    secondary: AlbiColors.primaryColorRed,
    tertiary: AlbiColors.primaryColorYellow,
    background: AlbiColors.backgroundColorLight,
    onBackground: AlbiColors.backgroundColorLighter,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AlbiColors.primaryColorRed,
    textTheme: ButtonTextTheme.primary,
  ),
  primaryColorLight: AlbiColors.backgroundColorLighter,
  backgroundColor: AlbiColors.backgroundColorDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AlbiColors.backgroundColorLight,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AlbiColors.backgroundColorLight,
    selectedIconTheme: IconThemeData(color: AlbiColors.primaryColorYellow),
    selectedItemColor: AlbiColors.primaryColorYellow,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: TextStyle(
      letterSpacing: 1.5,
      fontFamily: 'VarelaRound',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontFamily: 'VarelaRound',
      letterSpacing: 2,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline4: TextStyle(
      letterSpacing: 1,
      fontFamily: 'VarelaRound',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 16,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 14,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 14,
      color: Colors.grey,
    ),
    subtitle2: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 12,
      color: Colors.grey,
    ),
    caption: TextStyle(
      fontFamily: 'VarelaRound',
      fontSize: 10,
      color: Colors.grey,
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: AlbiColors.backgroundColorLighter,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.green,
    contentTextStyle: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
  ),


  cardColor: AlbiColors.backgroundColorLight,
  cardTheme: const CardTheme(
    color: AlbiColors.backgroundColorLight,
  ),
  scaffoldBackgroundColor: AlbiColors.backgroundColorDark,
  listTileTheme: ListTileThemeData(
    selectedColor: AlbiColors.backgroundColorLighter,
    selectedTileColor: AlbiColors.backgroundColorLighter,
    tileColor: AlbiColors.backgroundColorDark,
  ),
);
