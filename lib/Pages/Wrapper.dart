import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacc_app/Pages/Auth/authenticate.dart';
import 'package:vacc_app/Pages/Home.dart';
import 'package:vacc_app/Pages/Services/userModel.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context);
    return (_user == null) ? Authenticate() : Home();
  }
}
