import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vacc_app/Pages/Home/AddBaby.dart';
import 'package:vacc_app/Pages/Home/babies_list.dart';
import 'package:vacc_app/Pages/Home/editUser.dart';
import 'package:vacc_app/Pages/Services/authService.dart';
import 'package:vacc_app/Pages/Services/database.dart';
import 'package:vacc_app/Pages/Services/userModel.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                backgroundColor: Colors.pinkAccent[100],
                child: Text('Hello'),
              ),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
            ),
            ListTile(
                title: Text('Edit Info'),
                leading: Icon(Icons.info),
                onTap: () {
                  // _data.getBabiesList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditUser()),
                  );
                }),
            ListTile(
                title: Text('Sign out'),
                leading: Icon(Icons.exit_to_app_outlined),
                onTap: () async {
                  await _auth.signOut();
                })
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("My Babies"),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: ()  {
              setState(() {

              });

            },
          )
        ],
      ),
      body: BabiesList(),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBaby()));
        },
      ),
    );
  }
}
