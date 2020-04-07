import 'package:flutter/material.dart';
import 'package:mnadhem/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.deepOrange,
        ),
        home: Home());
  }
}
