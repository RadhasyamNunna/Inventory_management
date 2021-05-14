import 'dart:ui';
import 'package:inventory_management/main.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/home/home.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'googleprovider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {
  // dynamic result;
  final Authservice _auth =Authservice();
  bool isloading =false;

   Widget build(BuildContext context) {
    //var FF8C1128;
    return Scaffold(
      // backgroundColor: Color.cyanAccent ,
       backgroundColor: Color.fromARGB(255, 166, 3, 76) ,
      // appBar: AppBar(
      //   title: Text('login')
      // ),
      body: Container(
        //backgroundColor: Colors.cyan;
        padding: EdgeInsets.fromLTRB(50,100,50,100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image(
                image: AssetImage('assets/cartPink.png'),
              ),
            ),


          //   Expanded(
          //     flex: 1,
          //     child: TextButton(
          //     child: Text('Anon'),
          //     onPressed: () async {
          //       result =await _auth.signInAnon();
          //       if(result==null){
          //         print('error anon sign in');
          //       }
          //       else {
          //         print(result);
          //         Navigator.push(context, MaterialPageRoute(
          //                  builder: (context) => Home()));
          //         print('signedin');
          //         name=result.uid;
          //         print(result.uid);
          //       }
          //       },
          //     )
          // ),
            Expanded(
                flex: 1,
                child: SizedBox(height: 2,)),
            Expanded(
                flex: 1,
                child: isloading? Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    Text("Please wait..."),
                  ],
                  mainAxisSize: MainAxisSize.min,
                )
                :DecoratedBox(
                  decoration:
                  ShapeDecoration(shape: Border.symmetric(), color: Colors.white),
                  child: OutlinedButton.icon(
                      icon: FaIcon(FontAwesomeIcons.google),
                      label: Text('Google SignIn'),
                    onPressed: (){
                        // ('hi');
                        // setState(() {
                        //   isloading = true;
                        // });
                        final provider= Provider.of<GoogleSignInProvider>(context, listen: false);

                        // isloading=true;
                        // print('startedf-logging');
                        // print(provider.isSigningIn);
                        provider.login();
                        // print('logged');
                        // setState(() {
                        //   isloading = false;
                        // });
                        // isloading=provider.isSigningIn;
                        // print('hello');
                      }
                  ),
                )
            ),
            Expanded(
                flex: 4,
                child: SizedBox(height: 30,)),

            // logged(context),
        ]
        ),
    ),

    );
  }
}
