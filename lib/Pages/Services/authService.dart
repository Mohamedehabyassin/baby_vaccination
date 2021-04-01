import 'package:firebase_auth/firebase_auth.dart';
import 'package:vacc_app/Pages/Services/database.dart';
import 'package:vacc_app/Pages/Services/userModel.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User _user){
    return _user != null ? UserModel(uid: _user.uid): null ;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);


      User user = userCredential.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password:password);
      User user = userCredential.user;
      await DatabaseService(uid:user.uid).updateUserData(email,'');
      print(user.uid);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}