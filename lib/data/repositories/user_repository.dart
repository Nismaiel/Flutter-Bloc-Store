import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart'as http;
class UserRepository {
  Future register(String email, String password) async {
    try {

      final UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithCredentials(String email, String password) async {
    try {
      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait(
        [FirebaseAuth.instance.signOut(), GoogleSignIn().signOut()]);
  }

  isSignedIn() {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      return currentUser != null;
    } catch (e) {
      print(e.toString());
    }
  }
  Future<User?> signInWithGoogle() async {
    try{final googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    return FirebaseAuth.instance.currentUser;}on FirebaseAuthException catch(e){
      debugPrint(e.toString());
    }
  }

Future forgetPassword(String email)async{
try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

}on FirebaseAuthException catch(e){
  print(e.code);
  print(e.message);
}}
Future passwordResetConfirmation(String code,String newPassword)async{
    await FirebaseAuth.instance.confirmPasswordReset(code: code, newPassword: newPassword);
}


}
