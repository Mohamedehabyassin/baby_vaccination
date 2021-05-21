import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacc_app/Pages/Services/BabyModel.dart';

class DatabaseService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("User");

  DatabaseService() {
    getBabiesList();
  }

  List babies = [];

  Future<void> addUser(String name, String gender) async {
    final User user = auth.currentUser;
    return await userCollection
        .doc(user.uid)
        .set({'userName': name, 'gender': gender, 'babies': []})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addBaby(String babyName, String babyGender,
      String babyBirthday) async {
    final User user = auth.currentUser;
    Map<String, dynamic> regionData = new Map<String, dynamic>();
    regionData["babyName"] = babyName;
    regionData["babyGender"] = babyGender;
    regionData["babyBirthday"] = babyBirthday;

    DocumentReference currentRegion = FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .collection('Babies')
        .doc(babyName);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.set(currentRegion, regionData);
      print("instance created");
    });
    getBabiesList();
    notifyListeners();
  }

  Future getUserData() async {
    final User user = auth.currentUser;
    return userCollection.doc(user.uid).get();
  }

  Future updateUserData(String userName, String gender) async {
    final User user = auth.currentUser;
    final userId = user.uid;
    return await userCollection.doc(userId).update({
      'userName': userName,
      'gender': gender,
    });
  }

  Future getBabiesList() async {
    final User user = auth.currentUser;
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .collection("Babies");
    QuerySnapshot data = await collectionReference.get();

     babies = data.docs.map((QueryDocumentSnapshot e) {
        return e.data();
    }).toList();

     notifyListeners();

  }
  //
  // List<BabyModel> _babiesFromSnapShot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((data) {
  //     return BabyModel(
  //       babyName: data.data()['userName'] ?? '',
  //       babyGender: data.data()['gender'] ?? '',
  //       babyBirthDate: data.data()['numberOfBabies'] ?? '',
  //     );
  //   }).toList();
  // }

//   // get user Stream
//   Stream<QuerySnapshot> get userNewData {
//     return userCollection.snapshots();
//   }
//   //get streams
// Stream<List<BabyModel>> get data{
//     return userCollection.snapshots().map((_babiesFromSnapShot));
//
// }

}
