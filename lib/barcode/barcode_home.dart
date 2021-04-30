import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_management/fonts/my_flutter_app_icons.dart';
import 'package:inventory_management/screens/home/home.dart';
import 'package:inventory_management/screens/authentication/googleprovider.dart';
import 'package:inventory_management/services/api_class.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;

import '../main.dart';


class Barcode_home extends StatefulWidget {

  @override
  _Barcode_homeState createState() => _Barcode_homeState();
}

class _Barcode_homeState extends State<Barcode_home> {
  static const IconData account_circle_outlined = IconData(0xe010, fontFamily: 'MaterialIcons');
  static const IconData userIcon= IconData(0xe009, fontFamily: 'MaterialIcons');
  static const IconData user=MyFlutterApp.user;
  var result='kya hein ye ';





  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      codes.add(barcodeScanRes);
      code_names.add(getData(barcodeScanRes));
      print(codes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      result = barcodeScanRes;
    });
  }
  // Future<void> userProfile()async{
  //   return Navigator.push(context, MaterialPageRoute(
  //       builder: (context){
  //        return Home();
  //       }
  //   )
  //     ,);
  //
  // }

  Widget Ourlist(BuildContext context){
    print('hello');
    if(codes.length==0){
      return Center(child: Text('Add item',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),));
    }
    else{
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(12, 10, 15, 12),
        itemCount: codes.length,
        itemBuilder: (context,int index){
          return ListTile(
            leading: Icon(Icons.list),
            title: Text('${codes[index]}'),
          );
        }
        );
  }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawerScrimColor: Colors.transparent,
      appBar: AppBar(
        title: Text('My List'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            tooltip: 'Profile',
          onPressed: () async{
                    final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return Home();
                      }
                      )
                    ,);
                    },

              icon: Icon(
                user,
                size: 17,
              ),
          ),
        ],
      ),
      body: Ourlist(context),
      floatingActionButton: Container(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.camera_enhance),
          label: Text('Scan'),
          onPressed: () =>scanBarcodeNormal(),
        ),
      ),
      drawer: Drawer(
        // elevation: 15,
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              height: 100,
              child: DrawerHeader(
                child: Center(child: Text('IM')),
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
              ),
            ),
            Image(
              // height: 1830px,
           // width: 1340,
           image: AssetImage('assets/cartPink.png'),),
        //     DrawerHeader(
        //
        //       child: Image(
        //     image: AssetImage('assets/cartPink.png'),
        // ),
            //   child: Text('Drawer Header'),
            //   decoration: BoxDecoration(
            //     // color: Colors.blue,
            //     child: Image(
            //     image: AssetImage('assets/cartPink.png'),)
            //   ),
            // ),
            ListTile(
              // selectedTileColor: Colors.amber,
              title: Text('Clear list',style: TextStyle(fontSize: 18),),
              onTap: (){print('hello');
              codes.clear();
              setState(() {});
              print(codes.length);
              },
            ),
            Divider(height: 2,thickness: 1,indent: 7,endIndent: 5,),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              // selectedTileColor: Colors.blue,
              // leading: Icon(user,size: 15,),
              // title: Text('Profile'),
              title: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.body1,
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 9,0),
                        // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(user,size: 18,),
                      ),
                    ),
                    // SizedBox(width: 5,),
                    TextSpan(text: 'Profile',style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              // minLeadingWidth: 5,
              onTap: () async{
                final provider= Provider.of<GoogleSignInProvider>(context,listen: false);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()),);
              },
            )
          ],
        ),

      ),
    );
  }
}

Future<APIClass> getData(code) async{
  //making request
  http.Response response = await http.get(Uri.parse('file:///C:/Users/Shiva/Documents/cppbox/barcode=$code.html'));
  final data = jsonDecode(response.body);

  return APIClass.fromJson(data);

}