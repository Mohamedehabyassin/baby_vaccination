import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacc_app/layout/home_layout.dart';
import 'package:vacc_app/modules/auth/authenticate.dart';
import 'package:vacc_app/model/user_model.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context);
    return (_user == null) ? Authenticate() : HomeLayout();
  }
}
