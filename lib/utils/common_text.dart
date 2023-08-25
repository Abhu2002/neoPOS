import 'package:flutter/material.dart';

import 'app_colors.dart';

class AuthCustomTextfield extends StatefulWidget {
  final String? hint;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Function(String)? onChange;
  final String? errorText;
  final IconData? prefixIcon;

  const AuthCustomTextfield(
      {Key? key,
      this.onChange,
      this.hint,
      this.suffixIcon,
      this.obscureText,
      this.errorText,
      this.prefixIcon})
      : super(key: key);

  @override
  State<AuthCustomTextfield> createState() => _AuthCustomTextfieldState();
}

class _AuthCustomTextfieldState extends State<AuthCustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
            color: Color.fromRGBO(245, 98, 98, 1.0),
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        errorText: widget.errorText,
        errorMaxLines: 2,
        suffixIcon: widget.suffixIcon,
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.primaryColor),
        hintText: widget.hint,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        hintStyle: const TextStyle(
            fontSize: 12, color: Color.fromRGBO(214, 214, 214, 1)),
      ),
    );
  }
}

class CommonText20 extends StatefulWidget {
  final String text;
  const CommonText20({Key? key, required this.text}) : super(key: key);

  @override
  State<CommonText20> createState() => _CommonText20State();
}

class _CommonText20State extends State<CommonText20> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}

class CommonText15 extends StatefulWidget {
  final String text;
  const CommonText15({Key? key, required this.text}) : super(key: key);
  @override
  State<CommonText15> createState() => _CommonText15State();
}

class _CommonText15State extends State<CommonText15> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white));
  }
}
