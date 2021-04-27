

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/main.dart';
import 'package:inventory_management/screens/authentication/googleprovider.dart';
import 'package:inventory_management/screens/authentication/signIn.dart';
import 'package:provider/provider.dart';
import 'package:inventory_management/screens/home/loginHome.dart';


// SignIn ,SignIn

class  Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
  //final uid= result.uid;
  final user= FirebaseAuth.instance.currentUser!;
  // final peru = user.displayName!;
  Widget Name(BuildContext context){
    // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
    name=user.displayName;
    // if(provider.isSigningIn){
    //   print('oookkk');
    //   //return buildLoading();
    // }else if(user.displayName!=null){
    //   print('b');
    //   print('${user.displayName}');
    //   //   name=user.displayName;
    //   // name= FirebaseAuth.instance.currentUser!.displayName;
    //   // return Home();
    // }
    // else {
    //   print('c');
    //   print('3');
    //   name= result.uid;
    // }
    // if(user.displayName == null){
    //   print('null');
    //   name= result.uid;
    // }
    // else{
    //   print('not null');
    //   //print(result.uid);
    //   print('4');
    //   print('${user.displayName}');
    //   name=user.displayName;
    // }
    return Text('$name');
  }
  // widget ForLogout(BuildContext context){
  //   return
  // }
  Future<void> forLogout() async{
    print('helloJi');
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    print('1');
    provider.logout();
    print('2');

}
  Widget Network(BuildContext context){
    if(user.displayName == null){
      print('null');
      //Url url= https://wallpapercave.com/w/wp2698719;
      return CircleAvatar(
        maxRadius: 25,
        backgroundImage: NetworkImage('https://wallpapercave.com/w/wp2698719'),
      );

    }
    else{
      print('not null');
      return CircleAvatar(
        maxRadius: 25,
        backgroundImage: NetworkImage('${user.photoURL}'),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // padding: EdgeInsets.fromLTRB(20, 20, 20,20),
                children: <Widget>[
                  Network(context),
                  Name(context),
                  ElevatedButton(
                    child: Text('logout'),
                    // onPressed: () => forLogout()
                    //    , )
              onPressed: () async{
                final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                forLogout();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return LoginHome();
                    }
                )
                  ,);
              },
                   )

                ],
              )),
        ),
        );


    //   new Directionality(
    //     textDirection: TextDirection.ltr,
    //     child: new Text('Hello')
    // );
  }
}
