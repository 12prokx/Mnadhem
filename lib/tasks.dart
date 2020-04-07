import 'package:flutter/material.dart';
import 'package:mnadhem/linethrow.dart';
import 'addbut.dart';
import 'dbhelper.dart';

class Task extends StatefulWidget {
  String date;
  @override
  Task({this.date, Key key}) : super(key: key);
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();
  bool validated = true;
  String errtext = "";
  String todoedited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>();
  var rows;

  Future<int> query() async {
    myitems = [];
    children = [];
    var rows = await dbhelper.queryspecific(widget.date);
    print('aamlna');
    rows.forEach((row) {
      myitems.add(row.toString());
      children.add(GestureDetector(
        onDoubleTap: () {
          dbhelper.deletedata(row['id']);
          setState(() {});
        },
        child: LineThrow(
          text: row['task'],
          line: false,
        ),
      ));
    });
    return rows.length;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text(
              "No Data",
            ),
          );
        } else {
          if (myitems.length == 0) {
            return Scaffold(
              backgroundColor: Colors.grey[900],
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(33.0),
                  child: Text(
                    "YOUR MINIMAL TASK IS 3 TASKS",
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[900],
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
