/* This is free and unencumbered software released into the public domain. */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_opencv/opencv.dart' as cv;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _versionString = "Unknown";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String versionString;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      versionString = await cv.versionString;
    }
    on PlatformException {
      versionString = "Failed to get OpenCV version.";
    }

    try {
      cv.Scalar scalar = new cv.Scalar(v0: 0, v1: 0, v2: 0/*,v3: 0*/);
      bool result = await scalar.isReal();
      debugPrint("the result is: " + result.toString());
    }
    on PlatformException {
      debugPrint("error");
    }

    try {
      cv.Scalar scalar = new cv.Scalar();
      debugPrint("Before: " + scalar.toString());
      await scalar.set([1, 2, 3, 3]);
      debugPrint("After: " + scalar.toString());
    }
    on PlatformException {
      debugPrint("error");
    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _versionString = versionString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("OpenCV for Flutter"),
        ),
        body: Center(
          child: Text("OpenCV version: $_versionString\n"),
        ),
      ),
    );
  }
}
