import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  var _opacity = 0.0;
  var _right = 200.0;
  var _top = 50.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    playAnimation();
  }

  void playAnimation() async {
    await new Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _opacity = 1;
      _right = 0;
      _top = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var widthRatio = width < 1400 ? width / 1400 : 1;
    var heightRatio = height < 900 ? height / 900 : 1;
    var scale = widthRatio < heightRatio ? widthRatio : heightRatio;

    return height < width
        ? Container(
            alignment: Alignment.center,
            color: Color(0xFFFFFFFF),
            child: Center(
              child: Container(
                width: 1920,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: null),
                    Container(
                      width: 1400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(child: null),
                          Transform.scale(
                            alignment: Alignment.topLeft,
                            scale: widthRatio,
                            child: Container(
                              width: 1400,
                              height: 900,
                              child: Row(
                                children: [
                                  Container(
                                    width: 700,
                                    child: Center(
                                      child: AnimatedOpacity(
                                        opacity: _opacity,
                                        duration: Duration(milliseconds: 500),
                                        child: AnimatedContainer(
                                          margin:
                                              EdgeInsets.only(right: _right),
                                          duration: Duration(milliseconds: 500),
                                          width: 800,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            width: 310,
                                            child: Image.asset(
                                                "assets/images/4page.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(child: null),
                                      Container(
                                        width: 600,
                                        height: 350,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 120),
                                              child: Image.network(
                                                  "/assets/assets/desc/4page_text.svg"),
                                            ),
                                            Container(height: 200, child: null),
                                            Container(height: 200, child: null),
                                            Container(height: 200, child: null),
                                          ],
                                        ),
                                      ),
                                      Container(child: null),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(child: null),
                        ],
                      ),
                    ),
                    Container(child: null),
                  ],
                ),
              ),
            ))
        : Stack(
            children: [
              Container(
                alignment: Alignment.center,
                color: Color(0xFFFFFFFF),
                child: Center(
                  child: Container(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 10),
                        child: Image.network(
                            "/assets/assets/desc/4page_text_mobile.svg"),
                      ),
                      AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 500),
                        child: AnimatedContainer(
                          margin: EdgeInsets.only(top: _right),
                          duration: Duration(milliseconds: 500),
                          child: Image.network(
                            "/assets/assets/images/4page.png",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 0,
                ),
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: (() {
                    _showDialog();
                  }),
                  child: Image.network(
                      "/assets/assets/desc/4page_button_mobile.svg"),
                ),
              ),
            ],
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
