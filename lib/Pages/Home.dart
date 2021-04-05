import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vacc_app/Pages/Home/babies_list.dart';
import 'package:vacc_app/Pages/Services/authService.dart';
import 'package:vacc_app/Pages/Services/database.dart';
import 'package:vacc_app/Pages/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userNewData,
      child: Scaffold(
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
                onTap: () {},
              ),
              ListTile(
                title: Text('Edit Info'),
                leading: Icon(Icons.info),
                onTap: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("My Babies"),
          backgroundColor: Colors.pink,
          actions: [
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.exit_to_app_outlined),
            )
          ],
        ),
        body: BabiesList(),
      ),
    );
  }
}

/*


      return StreamProvider<List<BabyModel>>.value(
      value: DatabaseService().data,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Babies"),
          backgroundColor: Colors.pink,
          actions: [
            IconButton(onPressed: () async {
              await _auth.signOut();
            },
              icon: Icon(Icons.exit_to_app_outlined),)
          ],
        ),
         body: BabiesList(),
        drawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,

                ),
              ),
              ListTile(
                title: Text('User Data'),
                leading: Icon(Icons.data_usage_sharp),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Help'),
                leading: Icon(Icons.help),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),


        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>AddBaby()));
          },

        ),
      ),
    );
    }

     */
