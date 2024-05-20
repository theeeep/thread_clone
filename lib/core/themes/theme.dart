// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      surfaceTintColor: Colors.black,
    ),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.black12,
      primary: Colors.white,
      onPrimary: Colors.black,
    ),
  );

  // static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
  //       borderSide: BorderSide(color: color, width: 3),
  //       borderRadius: BorderRadius.circular(10),
  //     );
  // static final darkThemeMode = ThemeData.dark().copyWith(
  //   scaffoldBackgroundColor: AppPallete.backgroundColor,
  //   appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
  //   inputDecorationTheme: InputDecorationTheme(
  //     contentPadding: const EdgeInsets.all(25),
  //     enabledBorder: _border(),
  //     focusedBorder: _border(AppPallete.gradient2),
  //   ),
  // );
}
