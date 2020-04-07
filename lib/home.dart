import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnadhem/addbut.dart';
import 'package:mnadhem/daily.dart';
import 'dbhelper.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  DateTime now = DateTime.now();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String date;
  int index;
  final dbhelper = Databasehelper.instance;
  DateTime _day;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Text(
                '13 DAYS STREAK',
                style: new TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.solid,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: PageView.builder(
        onPageChanged: _onPageViewChange,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          _day = widget.now.add(new Duration(days: index));
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Daily(
                  date: widget.now.add(new Duration(days: index)),
                ),
              ],
            ),
          );
        },
        itemCount: widget.now.month % 2 == 0
            ? 31 - widget.now.day
            : 32 - widget.now.day,
        controller: PageController(
          viewportFraction: 0.84,
        ),
      ),
    );
  }
}

_onPageViewChange(int page) {
  print("Current Page: " + page.toString());
}
