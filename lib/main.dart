// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/screens/home/loginHome.dart';
import 'package:inventory_management/services/api_class.dart';
// import 'package:inventory_management/screens/authentication/authenticate.dart';
// import 'package:inventory_management/screens/home/home.dart';

// import 'package:inventory_management/screens/wrapper/wrap.dart';
import 'package:inventory_management/test.dart';
//
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:inventory_management/screens/authentication/googleprovider.dart';

 dynamic result;
 dynamic name;
 List codes=[];
 List<Future<APIClass>> code_names=[];

// Future<void> main() async {
//   // print('hello');
//   print('hii prends');
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(ChangeNotifierProvider(
//       create: (context) => GoogleSignInProvider(),
//
//       child: MyApp()
//   ),
//   );
// }
Future<void> main() async {
  // print('hello');
  print('hii prends');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
          print(snapshot.hasData);
            return MyApp();
          }
        ),
  )
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginHome(),
      // Text('V.Good'),
      // Scaffold(
      //       body: Center(
      //           child: Text('hii')),
      //       ),
    );


      // MaterialApp(
      //   home: LoginHome(),
        // Wrapper(),
    // );
  }
}
