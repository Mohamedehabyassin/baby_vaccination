import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Messaging extends StatefulWidget {
  const Messaging({Key key}) : super(key: key);

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fcm.getToken().then((value) => print("token is " + value));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void initMessaging(){
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //
    // });
  }
  }

  void notificationPermission(){

}
