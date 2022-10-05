import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vacc_app/shared/data/database.dart';
import 'package:vacc_app/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(id: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await DatabaseService().addUser(email, '');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken != null) {
        final userCredential = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        await DatabaseService().addUser(userCredential.user.email, '');

        return userCredential.user;
      } else {
        throw FirebaseAuthException(message: "google id token missing ");
      }
    } else {
      throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
    }

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();

    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    switch (response.status) {
      case FacebookLoginStatus.Success:
        final accessToken = response.accessToken;
        final userCredential = await _auth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        await DatabaseService().addUser('', '');
        return userCredential.user;

      case FacebookLoginStatus.Cancel:
        throw FirebaseAuthException(message: "Sign in Aborted by User");

      case FacebookLoginStatus.Error:
        throw FirebaseAuthException(message: response.error.developerMessage);
      default:
        throw UnimplementedError();
    }
  }

  Future<void> signOut() async {
    try {
      final googleSingIn = GoogleSignIn();
      final facebookLogin = FacebookLogin();
      await googleSingIn.signOut();
      await facebookLogin.logOut();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
