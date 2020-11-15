import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Image image;
  VideoPlayerController _controller;
  var _opacity = 0.0;
  var _right = 200.0;
  var _top = 50.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/palette-landing.appspot.com/o/Palette%20UI%20%EB%8F%99%EC%98%81%EC%83%81%20%EC%88%98%EC%A0%95%EB%B3%B8.mp4?alt=media&token=4f4acedd-cfc5-4b84-af63-3aa63e27e19f")
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    image = Image.network("https://firebasestorage.googleapis.com/v0/b/palette-landing.appspot.com/o/Palette-UI.gif?alt=media&token=73c59888-abf4-4f18-8047-1a9fab13c5b6");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mutes the video
      _controller.setVolume(0);
      // Plays the video once the widget is build and loaded.
      _controller.play();
    });
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
    _controller.play();

    return height < width
        ? Container(
            alignment: Alignment.center,
            color: Color(0xFFF1F1F1),
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
                            scale: scale,
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
                                          height: 693,
                                          width: 321,
                                          child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              width: 310,
                                              child: VideoPlayer(_controller)),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 0.0), //(x,y)
                                                blurRadius: 20.0,
                                              ),
                                            ],
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
                                              child: Image.network(
                                                  "/assets/assets/desc/1page_text1.svg"),
                                            ),
                                            Container(
                                              child: Image.network(
                                                  "/assets/assets/desc/1page_text2.svg"),
                                            ),
                                            Container(
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _showDialog();
                                                  });
                                                },
                                                child: Image.network(
                                                    "/assets/assets/desc/1page_button.svg"),
                                              ),
                                            ),
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
            ),
          )
        : Container(
            alignment: Alignment.center,
            color: Color(0xFFF1F1F1),
            child: Center(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 50),
                    child: Image.network(
                        "/assets/assets/desc/1page_text_mobile.svg"),
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(top: _right),
                      width: width * 0.7,
                      height: width * 0.7 * 2.15,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: image,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0), //(x,y)
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
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
