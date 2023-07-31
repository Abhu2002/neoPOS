import 'package:flutter/material.dart';

class AppColors {
// Theme Primary Color
  static const primaryColor = Color(0xffec7905);
  static const backgroundColor = Color(0xffffffff);
  static const primaryColorValue = 0xffec7905;

// Text Colors
  static const textColor = Color(0x00000000);
  static const mainTextColor = Color(0xffec7905);
  static const subTextColor = Color(0xff2A2A2A);
  static const buttonTextColor = Color(0xffec7905);
  static const unavilableButtonColor = Color(0xff828282);

// Button Colors
  static const buttonColor = Color(0xffec7905);
  static const unavilableButtonColor = Color(0xff828282);

// Table Colors
  static const tableAvailableColor = Color(0xff55CA92);
  static const tableNotAvailableColor = Color(0xf5EC7904);
  static const tableAvailableTextColor = Color(0xf5EC7904);
  static const tableunAvailableTextColor = Color(0xffEBEBEB);

// Swatch Colors
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
