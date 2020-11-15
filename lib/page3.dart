import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  var _opacity1 = 0.0;
  var _opacity2 = 0.0;
  var _right1 = 200.0;
  var _right2 = 600.0;
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
      _opacity1 = 1;
      _right1 = 0;
      _top = 0;
    });
    await new Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _opacity2 = 1;
      _right2 = 300;
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
            color: Color(0xFFF1F1F1),
            child: Center(
              child: Container(
                width: 1920,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: null),
                    Transform.scale(
                      alignment: Alignment.topLeft,
                      scale: scale,
                      child: Container(
                        width: 1600,
                        height: 900,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: 1600,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(child: null),
                                  Container(
                                      width: 1600,
                                      height: 900,
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(child: null),
                                              Container(
                                                width: 600,
                                                height: 350,
                                                child: null,
                                              ),
                                              Container(child: null),
                                            ],
                                          ),
                                          Container(
                                            width: 1000,
                                            child: Center(
                                              child: AnimatedOpacity(
                                                opacity: _opacity2,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                child: AnimatedContainer(
                                                  margin: EdgeInsets.only(
                                                      left: _right2),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: 1000,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 100),
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    width: 310,
                                                    child: Image.asset(
                                                        "assets/images/3page2.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(child: null),
                                ],
                              ),
                            ),
                            Container(
                              width: 1400,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(child: null),
                                  Container(
                                      width: 1400,
                                      height: 900,
                                      child: Row(
                                        children: [
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
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 120),
                                                      child: Image.network(
                                                          "/assets/assets/desc/3page_text.svg"),
                                                    ),
                                                    Container(
                                                        height: 200,
                                                        child: null),
                                                    Container(
                                                        height: 200,
                                                        child: null),
                                                    Container(
                                                        height: 200,
                                                        child: null),
                                                  ],
                                                ),
                                              ),
                                              Container(child: null),
                                            ],
                                          ),
                                          Container(
                                            width: 600,
                                            child: Center(
                                              child: AnimatedOpacity(
                                                opacity: _opacity1,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                child: AnimatedContainer(
                                                  margin: EdgeInsets.only(
                                                      left: _right1),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: 600,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    width: 310,
                                                    child: Image.asset(
                                                        "assets/images/3page1.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(child: null),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                        "/assets/assets/desc/3page_text_mobile.svg"),
                  ),
                  AnimatedOpacity(
                    opacity: _opacity1,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(top: _right1),
                      duration: Duration(milliseconds: 500),
                      child: Image.network(
                        "/assets/assets/images/3page1.png",
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
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
          );
  }
}
