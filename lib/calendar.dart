import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;

class MyHomePage extends StatefulWidget {
  MyHomePage({
    this.date,
    Key key,
    this.title,
  }) : super(key: key);
  int date;
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate;
  DateTime _currentDate2;
  String _currentMonth;
  DateTime _targetDateTime;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime(2020, widget.date, 3);
    _currentDate2 = DateTime(2020, widget.date, 3);
    _targetDateTime = DateTime(2020, widget.date, 3);
    _currentMonth = DateFormat.yMMM().format(DateTime(2020, widget.date, 3));
  }

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Color(0xffF94200),
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      isScrollable: false,
      weekDayFormat: WeekdayFormat.narrow,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(color: Colors.white),
      thisMonthDayBorderColor: Colors.grey[900],
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 300.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),

      showHeader: false,

      selectedDayButtonColor: Color(0xffF94200),
      selectedDayBorderColor: Color(0xffF94200),
      daysTextStyle: TextStyle(color: Colors.white),
      selectedDayTextStyle: TextStyle(color: Colors.white),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey[900],
      ),
      nextDaysTextStyle: TextStyle(
        color: Colors.grey[900],
      ),

      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          child: new Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    _currentMonth,
                    style: TextStyle(
                      color: Color(0xffF94200),
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18.0),
          child: _calendarCarouselNoHeader,
        )
      ],
    );
  }
}
