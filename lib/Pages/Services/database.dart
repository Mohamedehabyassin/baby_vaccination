import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vacc_app/Pages/Services/BabyModel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  BabyModel _babyModel = BabyModel();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");
  Future addUserData() async {


  }
  Future updateUserData(String userName,String gender) async {
    return await userCollection.doc(uid).set({
      'userName': userName,
      'gender': gender,

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