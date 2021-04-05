import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vacc_app/Pages/Services/BabyModel.dart';

class DatabaseService extends ChangeNotifier{
  final String uid;
  DatabaseService({this.uid});

  BabyModel _babyModel = BabyModel();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");

  Future<void> addUser(String name,String gender) {
    return userCollection
        .add({
      'username': name,
      'gender': gender,
      'babies': []
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future updateUserData(String userName,String gender) async {
    return await userCollection.doc(uid).set({
      'userName': userName,
      'gender': gender,
      'babies': [],

    });
  }


  List<BabyModel> _babiesFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((data){
      return BabyModel(
        babyName: data.data()['userName'] ?? '',
        babyGender: data.data()['gender'] ?? '',
        babyBirthDate: data.data()['numberOfBabies'] ?? '',
      );
    }).toList();

  }

  // get user Stream
  Stream<QuerySnapshot> get userNewData {
    return userCollection.snapshots();
  }
  //get streams
Stream<List<BabyModel>> get data{
    return userCollection.snapshots().map((_babiesFromSnapShot));

}


}