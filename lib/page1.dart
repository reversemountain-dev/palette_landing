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
        "https://firebasestorage.googleapis.com/v0/b/palette-landing.appspot.com/o/Palette%20%EB%8F%99%EC%98%81%EC%83%81.mp4?alt=media&token=7b09899c-0cb7-4349-84ec-25b342444957")
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    image = Image.network(
        "https://firebasestorage.googleapis.com/v0/b/palette-landing.appspot.com/o/Palette-%EB%8F%99%EC%98%81%EC%83%81.gif?alt=media&token=7d156be1-b901-4076-8af4-8c0869b4fc09");
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

          var width = MediaQuery.of(context).size.width;
          var height = MediaQuery.of(context).size.height;
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              content: Container(
                color: Color(0xFFFCFCFF),
                width: width / 2,
                height: height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("/assets/assets/images/logo.png",
                          width: width / 6),
                      SizedBox(height: 30),
                      Image.network("/assets/assets/desc/apply.svg",
                          width: width / 6),
                      SizedBox(height: 60),
                      Container(
                        width: 400,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "이름을 입력하세요",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        height: 30,
                        width: 400,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 350,
                                child: TextField(
                                  autofocus: false,
                                  onChanged: _validate,
                                  controller: _nameController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: " "),
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
                      SizedBox(height: 30),
                      Container(
                        width: 400,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "이메일을 입력하세요",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        height: 30,
                        width: 400,
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 350,
                                  child: TextField(
                                    autofocus: false,
                                    onChanged: _validate,
                                    controller: _emailController,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: " "),
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
                      SizedBox(height: 30),
                      Container(
                        width: 400,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "지금 즐기는 취미를 입력하세요",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        height: 30,
                        width: 400,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 350,
                                child: TextField(
                                  autofocus: false,
                                  onChanged: _validate,
                                  controller: _hobbyController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: " "),
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
                      SizedBox(height: 60),
                      Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 50,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          color: Color(0xFF533AFF),
                          height: 60,
                          minWidth: 150,
                          disabledColor: Colors.grey,
                          onPressed: _isButtonEnabled ? _submit : null,
                          child: Image.network(
                              "/assets/assets/desc/apply_button.svg",
                              width: 100),
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
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
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
