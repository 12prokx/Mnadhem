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
  void addtodo() async {
    Map<String, dynamic> row = {
      Databasehelper.columnTask: todoedited,
      Databasehelper.columnDate: widget.date,
    };
    final id = await dbhelper.insert(row);

    Navigator.pop(context);
    todoedited = "";
    setState(() {
      validated = true;
      errtext = "";
    });
  }

  Future<int> query() async {
    myitems = [];
    children = [];
    var rows = await dbhelper.queryspecific(widget.date);

    rows.forEach((row) {
      myitems.add(row.toString());
      children.add(GestureDetector(
        onDoubleTap: () {
          dbhelper.deletedata(row['id']);
          setState(() {});
        },
        child: LineThrow(
          iD: row['id'],
          text: row['task'],
          line: false,
        ),
      ));
    });
    return rows.length;
  }

  void showalertdialog() {
    texteditingcontroller.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(
                "Add Task",
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: texteditingcontroller,
                    autofocus: true,
                    onChanged: (_val) {
                      todoedited = _val;
                    },
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                    ),
                    decoration: InputDecoration(
                      errorText: validated ? null : errtext,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if (texteditingcontroller.text.isEmpty) {
                              setState(() {
                                errtext = "Can't Be Empty";
                                validated = false;
                              });
                            } else if (texteditingcontroller.text.length >
                                512) {
                              setState(() {
                                errtext = "Too may Chanracters";
                                validated = false;
                              });
                            } else {
                              addtodo();
                            }
                          },
                          color: Color(0xffF94200),
                          child: Text("ADD",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Raleway",
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: query(),
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
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: showalertdialog,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
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
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: showalertdialog,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
