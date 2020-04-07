import 'package:flutter/material.dart';

import 'dbhelper.dart';

class LineThrow extends StatefulWidget {
  bool line;
  int iD;
  String text;
  LineThrow({
    this.iD,
    this.line,
    this.text,
    Key key,
  });

  @override
  _LineThrowState createState() => new _LineThrowState();
}

class _LineThrowState extends State<LineThrow> with TickerProviderStateMixin {
  bool completed = false;
  AnimationController controller;
  Animation animation;
  final dbhelper = Databasehelper.instance;
  void makeline(int id, int line) {
    print('xxxxxxxxxxxxxxxx');
  }

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
      duration: new Duration(milliseconds: 800),
      vsync: this,
    );

    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeOut);

    animation = new Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        linethrwtext(widget.text),
      ],
    );
  }

  GestureDetector linethrwtext(String text) {
    return widget.line == true
        ? GestureDetector(
            onTap: () {
              controller.forward(from: 0.0);
              setState(() {
                widget.line = false;

                print(widget.line);
              });
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: new Stack(
                    children: <Widget>[
                      new Text(
                        text,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      new Container(
                        transform: new Matrix4.identity()
                          ..scale(
                            animation.value,
                            1.0,
                          ),
                        child: new Text(
                          text,
                          style: new TextStyle(
                            color: Colors.transparent,
                            decorationColor: Color(0xffF94200),
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3,
                            fontSize: 40,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          )
        : GestureDetector(
            onLongPressMoveUpdate: (details) {
              if (details.localPosition.dx > 4) {
                setState(() {
                  completed = false;
                  widget.line = true;
                  print(widget.line);
                });

                controller.forward(from: 0.0);
              }
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: new Stack(
                    children: <Widget>[
                      new Text(
                        text,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      new Container(
                        transform: new Matrix4.identity()
                          ..scale(
                            animation.value,
                            1.0,
                          ),
                        child: new Text(
                          text,
                          style: new TextStyle(
                            color: Colors.transparent,
                            decorationColor: Color(0xffF94200),
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: widget.line == false
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                            decorationThickness: 3,
                            fontSize: 40,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          );
  }
}
