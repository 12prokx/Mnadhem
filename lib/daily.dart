import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mnadhem/tasks.dart';

import 'dbhelper.dart';

class Daily extends StatelessWidget {
  DateTime date;
  DateTime _now = DateTime.now();
  DateTime now = DateTime.now();
  final dbhelper = Databasehelper.instance;
  var rows;
  dynamic get() async {
    rows = await dbhelper.getcount(DateFormat('MMMM-dd').format(_now));
    return 2;
  }

  Daily({this.date, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    get();
    String x = DateFormat('MMMM-dd').format(_now);

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Text('$rows TASKS FOR TODAY',
                  style: new TextStyle(
                    color: Colors.grey,
                    decorationColor: Colors.grey,
                    fontSize: 15,
                  )),
              Text(
                x == DateFormat('MMMM-dd').format(date)
                    ? 'TODAY'
                    : DateFormat('MMMM-dd')
                                .format(_now.add(Duration(days: 1))) ==
                            DateFormat('MMMM-dd').format(date)
                        ? 'TOMMOROW'
                        : DateFormat('MMMM-dd').format(date),
                style: TextStyle(color: Color(0xffF94200), fontSize: 55),
              ),
            ],
          ),
        ),
        Container(
            height: 650,
            width: 400,
            child: Task(
              date: DateFormat('MMMM-dd').format(date),
            )),
      ],
    );
  }
}
