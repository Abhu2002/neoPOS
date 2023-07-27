import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const CustomOutlineButton(
      {required this.text, required this.onPress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
        child: Text(text),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1.0, color: AppColors.primaryColor),
        ),
        onPressed: onPress,
      ),
    );
  }
}
