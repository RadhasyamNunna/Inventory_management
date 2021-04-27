import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/barcode/barcode_home.dart';
import 'package:inventory_management/screens/authentication/googleprovider.dart';
import 'package:inventory_management/screens/authentication/signIn.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:inventory_management/main.dart';
import 'package:inventory_management/test.dart';

class LoginHome extends StatelessWidget {
  var x=0;
  Widget BuildLoading() => Center(
    child: CircularProgressIndicator(),
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
              print(snapshot.hasData);
              if(snapshot.hasData){
                print('change');
                x=1;
              }
            if(provider.isSigningIn){
              print('a');
              return BuildLoading();
            }else if(x==1){
              print('b,$x');

              name= FirebaseAuth.instance.currentUser!.displayName;
              // return Test();
              print('not');
              // return LoginHome();
              print('end');
              if(provider.isSigningIn) {
                print('a');
                return BuildLoading();
              }
              return Barcode_home();
            }
            else {
              print('c');
              return SignIn();
            }
            }),
      )
    );
  }

}
