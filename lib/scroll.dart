import 'package:flutter/material.dart';
import 'package:mnadhem/calendar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'calendar',
            style: new TextStyle(
              color: Colors.white,
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.solid,
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.grey[900],
        body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return MyHomePage(date: index + 3);
          },
          itemCount: 12200,
          viewportFraction: 0.86,
          scale: 1,
        ));
  }
}
