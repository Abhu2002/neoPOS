import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xffec7905);
  static const backgroundColor = Color(0xffffffff);
  static const primaryColorValue = 0xff074BCF;

  static const primarySwatch = MaterialColor(
    AppColors.primaryColorValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(AppColors.primaryColorValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}
