import 'package:flutter/material.dart';
import 'package:vacc_app/Pages/Auth/register.dart';
import 'package:vacc_app/Pages/Auth/signIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}
class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView: toggleView) : Register(
        toggleView: toggleView);
  }
}