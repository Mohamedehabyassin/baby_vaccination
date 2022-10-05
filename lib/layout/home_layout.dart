import 'package:flutter/material.dart';
import 'package:vacc_app/modules/map/hospital.dart';
import 'package:vacc_app/modules/screen/add_baby.dart';
import 'package:vacc_app/modules/screen/babies_list.dart';
import 'package:vacc_app/modules/screen/edit_user.dart';
import 'package:vacc_app/shared/auth_service.dart';

class HomeLayout extends StatelessWidget {
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
                backgroundColor: Colors.blue[900],
                child: Text('Hello'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[700],
              ),
            ),
            ListTile(
                title: Text('Edit Info'),
                leading: Icon(Icons.info),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditUser()),
                  );
                }),
            ListTile(
                title: Text('Hospital'),
                leading: Icon(Icons.house_siding_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Hospital()),
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
        backgroundColor: Colors.indigo[900],
      ),
      body: BabiesList(),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBaby()));
        },
      ),
    );
  }
}
