import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palette Service',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Palette Landing Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: missing_return
  Future<void> incrementCounter() {
    //FirebaseFirestore.instance.collection('email').add({'email': 'email$_counter'});
  }
  PageController _pageController = new PageController();

  final TextEditingController _textController = new TextEditingController();
  _moveUp() async {
    await Future.delayed(Duration(microseconds: 10));
    _pageController
        .previousPage(
            duration: Duration(milliseconds: 500), curve: Curves.linear)
        .then((value) {
      print("p");
    });
  }

  _moveDown() async {
    await Future.delayed(Duration(microseconds: 10));
    _pageController
        .nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear)
        .then((value) {
      print("n");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {
            if (event.scrollDelta.dy > 0) {
              _moveDown();
            } else if (event.scrollDelta.dy < 0) {
              _moveUp();
            }
          }
        },
        child: Stack(
          children: [
            PageView(
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              controller: _pageController,
              children: [
                Page1(),
                Page2(),
                Page3(),
                Page4(),
              ],
            ),
            height < width
                ? Container(child: null)
                : Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Color(0xFF533AFF),
                      width: MediaQuery.of(context).size.width,
                      height: 67,
                      child: FlatButton(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.network(
                                "/assets/assets/desc/4page_button_mobile.svg",
                                width: MediaQuery.of(context).size.width / 2)),
                        onPressed: (() {
                          _showDialog();
                        }),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _hobbyController = TextEditingController();
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var _isButtonEnabled = false;

        return StatefulBuilder(builder: (context, setState) {
          void _validate(String value) {
            if (_hobbyController.text != "" &&
                _nameController.text != "" &&
                EmailValidator.validate(_emailController.text)) {
              setState(() {
                _isButtonEnabled = true;
              });
            } else {
              setState(() {
                _isButtonEnabled = false;
              });
            }
          }

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              content: Container(
                width: 350.0,
                height: 500.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Palette 신청하기",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 35),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        height: 30,
                        width: 220,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 170,
                                child: TextField(
                                  autofocus: false,
                                  onChanged: _validate,
                                  controller: _nameController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: "이름"),
                                ),
                              ),
                              Container(
                                width: 30,
                                child: Icon(Icons.check,
                                    color: _nameController.text != ""
                                        ? Colors.green
                                        : Colors.transparent),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        height: 30,
                        width: 220,
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 170,
                                  child: TextField(
                                    autofocus: false,
                                    onChanged: _validate,
                                    controller: _emailController,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: "이메일"),
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  child: Icon(Icons.check,
                                      color: EmailValidator.validate(
                                              _emailController.text)
                                          ? Colors.green
                                          : Colors.transparent),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        height: 30,
                        width: 220,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 170,
                                child: TextField(
                                  autofocus: false,
                                  onChanged: _validate,
                                  controller: _hobbyController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: "취미"),
                                ),
                              ),
                              Container(
                                width: 30,
                                child: Icon(Icons.check,
                                    color: _hobbyController.text != ""
                                        ? Colors.green
                                        : Colors.transparent),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                          height: 50,
                          child: Text("앱 신청은 이메일 수신에 \n동의 함을 뜻합니다.")),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        width: 286,
                        height: 80,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xFF533AFF),
                          height: 60,
                          minWidth: 150,
                          disabledColor: Colors.grey,
                          onPressed: _isButtonEnabled ? _submit : null,
                          child: Text(
                            "신청",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _submit() {
    FirebaseFirestore.instance.collection('email').add({
      'name': _nameController.text,
      'email': _emailController.text,
      'hobby': _hobbyController.text,
      'datetime': DateTime.now()
    });
    Navigator.of(context, rootNavigator: true).pop();
    _thankyou();
  }

  void _thankyou() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            content: Container(
              width: 350.0,
              height: 200.0,
              child: Center(
                  child: Image.network("/assets/assets/desc/thankyou.svg",
                      width: 300)),
            ),
          ),
        );
      },
    );
  }
}
