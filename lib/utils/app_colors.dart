import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xffec7905);
  static const backgroundColor = Color(0xffffffff);
  static const primaryColorValue = 0xffec7905;

  static const primarySwatch = MaterialColor(
    AppColors.primaryColorValue,
    <int, Color>{
      50: Color(0xFFFFF3E0),
      100: Color(0xFFFFE0B2),
      200: Color(0xFFFFCC80),
      300: Color(0xFFFFB74D),
      400: Color(0xFFFFA726),
      500: Color(AppColors.primaryColorValue),
      600: Color(0xFFFB8C00),
      700: Color(0xFFF57C00),
      800: Color(0xFFEF6C00),
      900: Color(0xFFE65100),
    },
  );
}
