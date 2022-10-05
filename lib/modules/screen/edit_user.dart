import 'package:flutter/material.dart';
import 'package:vacc_app/shared/data/database.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  String _name = '';
  String _gender = '';
  DatabaseService _service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(child: Text('Edit Data')),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 70,
          width: 200,
        ),
        Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    _name = val;
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle_rounded,
                  ),
                  border: InputBorder.none,
                  hintText: "Name",
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              Divider(),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    _gender = val;
                  });
                },
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                    ),
                    border: InputBorder.none,
                    hintText: "Gender",
                    contentPadding: EdgeInsets.all(10)),
              ),
            ],
          ),
          height: 160,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.cyan[400]),
        ),
        Container(
          width: 150,
          height: 70,
          margin: EdgeInsets.symmetric(horizontal: 70),
          padding: EdgeInsets.only(top: 20),
          child: ElevatedButton(
            child: Text('Edit Data '),
            onPressed: () async {
              await _service.updateUserData(_name, _gender);
              setState(() {
                _name = '';
                _gender = '';
              });
            },
          ),
        ),
      ]),
    );
  }
}
