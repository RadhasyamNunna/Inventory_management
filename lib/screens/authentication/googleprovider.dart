import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn=false;
  GoogleSignInProvider(){
    _isSigningIn = false;
  }
  bool get isSigningIn=> _isSigningIn;
  set isSigningIn(bool isSigningIn){
    _isSigningIn = isSigningIn;
    notifyListeners();
  }
  Future login() async{

    isSigningIn=true;
    final user = await googleSignIn.signIn();
    if(user==null){
      isSigningIn = false;
      return;
    } else{
      final googleAuth =await user.authentication;
      final credential =GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn =false;
    }

  }
  void logout() async{
    print('logout');
    await googleSignIn.disconnect();
    print('tata');
    await _auth.signOut();
    print('bye');
  }
}