import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      body: Center(
          child: Image.asset(
        'assets/images/StartImage.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      )),
    );
  }
}
