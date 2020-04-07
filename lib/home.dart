import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      Databasehelper.columnDate: DateFormat('MMMM-dd').format(
        widget.now.add(new Duration(days: index)),
      ),
    };
    final id = await dbhelper.insert(row);
    print('addddddiiiiing');

    Navigator.pop(context);
    todoedited = "";
    setState(() {
      validated = true;
      errtext = "";
    });
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

  _onPageViewChange(int page) {
    print("Current Page: " + page.toString());
    index = page;
  }

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
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            onPressed: showalertdialog,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}
