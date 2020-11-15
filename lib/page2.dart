import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  var _opacity = 0.0;
  var _right = 200.0;
  var _right_mobile = 200.0;

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
                                              "assets/images/2page.png",
                                            ),
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
                                                  "/assets/assets/desc/2page_text.svg"),
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
        : Container(
            alignment: Alignment.center,
            color: Color(0xFFFFFFFF),
            child: Center(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 10),
                    child: Image.network(
                        "/assets/assets/desc/2page_text_mobile.svg"),
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(top: _right_mobile),
                      duration: Duration(milliseconds: 500),
                      child: Image.network(
                        "/assets/assets/images/2page.png",
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            _right_mobile = 0;

                            return child;
                          }
                          return Container(child: null);
                        },
                      ),
                    ),
                  ),
                ],
              )),
            ),
          );
  }
}
