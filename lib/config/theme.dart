import 'package:flutter/material.dart';
import 'package:albi_hry/config/colors.dart';


ThemeData albi_theme = ThemeData.dark()
    .copyWith( // možná appbar hodit průhledy jak HBO appka
  useMaterial3: true,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AlbiColors.primaryColorBlue,
    secondary: AlbiColors.primaryColorRed,
    tertiary: AlbiColors.primaryColorYellow,
    background: AlbiColors.backgroundColorLight,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AlbiColors.primaryColorRed,
    textTheme: ButtonTextTheme.primary,
  ),
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
  ),
);