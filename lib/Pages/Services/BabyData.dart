import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyNewApp extends StatelessWidget {
  //final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");

  final databaseReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FireStore Demo'),
        ),
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  child: Text('Create Record'),
                  onPressed: () {
                    createRecord();
                  },
                ),
                RaisedButton(
                  child: Text('View Record'),
                  onPressed: () {
                    getData();
                  },
                ),
              ],
            )), //center
      ),
    );
  }

  void createRecord() async {
    await databaseReference.collection("books")
        .doc("1")
        .set({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.id);
  }

  void getData() {
    databaseReference
        .collection("books")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => print('${f.data}}'));
    });
  }
}
