import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:vacc_app/layout/wrapper.dart';

class MySplashScreen extends StatelessWidget {
  final animationType = "tap";

  @override
  Widget build(BuildContext context) {
    Widget animated = SplashScreen.navigate(
      name: 'assets/doctor.flr',
      next: (context) => Wrapper(),
      until: () => Future.delayed(Duration(seconds: 5)),
      startAnimation: animationType,
      backgroundColor: Colors.black,
    );
    return Scaffold(
      body: animated,
    );
  }
}
