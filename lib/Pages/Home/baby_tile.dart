import 'package:flutter/material.dart';
import 'package:vacc_app/Pages/Services/BabyModel.dart';

class BabyTile extends StatelessWidget {

  final BabyModel babyModel;

  BabyTile({this.babyModel});
  @override
  Widget build(BuildContext context) {
        return Padding(
        padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.all(20),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.pink,
          ),
          title: Text(babyModel.babyName),
          subtitle: Text("Birthday ${babyModel.babyBirthDate}"),
          trailing: Text("${babyModel.babyGender}"),
        ),

      ),
    );
  }
}
