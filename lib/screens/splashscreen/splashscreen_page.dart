import 'dart:async';

import 'package:flutter/material.dart';

import '../../navigation/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2000), () {
      // set your desired delay time here
      Navigator.pushReplacementNamed(context, RoutePaths.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: (MediaQuery.of(context).size.width > 850)
            ? Image.asset("assets/splash_screen_image.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill)
            : Image.asset("assets/login_page_image.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitHeight),
      ),
    );
  }
}
