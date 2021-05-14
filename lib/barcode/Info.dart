// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:inventory_management/barcode/barcode_home.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/main.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_management/barcode/Info.dart';
import 'package:inventory_management/fonts/my_flutter_app_icons.dart';
import 'package:inventory_management/item.dart';
import 'package:inventory_management/screens/home/home.dart';
import 'package:inventory_management/screens/authentication/googleprovider.dart';
import 'package:inventory_management/services/api_class.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../main.dart';


class Info extends StatefulWidget {
  // const Item({Key key}) : super(key: key);
  int index=0;
  Info(this.index);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Widget Edit(BuildContext){
    final GlobalKey<FormState> _key= GlobalKey<FormState>();
    final nameControl =TextEditingController(text: goodsNames[widget.index]['id']);
    final costControl =TextEditingController(text: goodsNames[widget.index]['cost'].toString());
    final quantityControl=TextEditingController(text: goodsNames[widget.index]['quantity'].toString());
    return Material(
      child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nameControl,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Item Name*',
                    // initialValue: "I am smart"
                    // initialValue: 'fg',

                  ),
                ),
                TextFormField(
                  controller: costControl,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Cost',
                  ),
                  keyboardType: TextInputType.number ,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                TextFormField(
                  controller: quantityControl,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Quantity',

                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                ElevatedButton(onPressed: () async {
                  // print(nameControl.text);
                  // print(codes.length);
                  // print(goods.length);
                  // int l=goods.length-1;
                  goodsNames[widget.index]['id']=nameControl.text;
                  goodsNames[widget.index]['cost']=int.parse(costControl.text);
                  goodsNames[widget.index]['quantity']=int.parse(quantityControl.text);
                  await FirebaseFirestore.instance.collection('store').doc(inputData()).update({'goods': goodsNames });
                  setState(() {

                  });
                  Navigator.pop(BuildContext);
                  }
                  , child: Text('submit'),),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name: ${goodsNames[widget.index]['id']}'),
                // Text(goodsNames[index]['id']),
              ],
            ),
            Text('Barcode: ${goodsNames[widget.index]['bcode']}'),
            Text('code: Rs.${goodsNames[widget.index]['cost']}'),
            Text('Quantity: ${goodsNames[widget.index]['quantity']}'),
            ElevatedButton.icon(onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit(context)));
            }, icon: Icon(Icons.edit), label: Text('edit'))
          ],
        ),
      )
    );
  }
}
