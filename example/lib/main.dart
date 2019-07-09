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

  static const bool TEST_SCALAR = false;
  static const bool TEST_RANGE = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String versionString = "OK";

    //await testInfo(versionString);
    await testRange();
    await testScalar();

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

  Future<void> testRange() async {
    if (TEST_RANGE) {
      printSeparator("TESTING RANGE");
      // set()
      try {
        printSeparator("Testing set()");
        cv.Range range = new cv.Range();
        debugPrint("Before range.set(): " + range.toString());
        await range.set([10, 20]);
        debugPrint("After range.set(): " + range.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> testInfo(String versionString) async {
    // getVersionString()
    try {
      cv.Information information = cv.Information();
      versionString = await information.getVersionString();
      printSeparator("Testing getVersionString()");
      debugPrint("OpenCV version: " + versionString);
    } on PlatformException {
      versionString = "Failed to get OpenCV version.";
    }

    // getBuildInformation()
    try {
      cv.Information information = cv.Information();
      String buildInfo = await information.getBuildInformation();
      printSeparator("Testing getBuildInformation()");
      debugPrint("Build Info: " + buildInfo);
    } on PlatformException {
      versionString = "Failed to get OpenCV version.";
    }
  }

  Future<void> testScalar() async {
    if (TEST_SCALAR) {
      printSeparator("TESTING SCALAR");
      // set()
      try {
        printSeparator("Testing set()");
        cv.Scalar scalar = new cv.Scalar();
        debugPrint("Before scalar.set(): " + scalar.toString());
        await scalar.set([1, 2, 3, 3]);
        debugPrint("After scalar.set(): " + scalar.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }

      // all()
      try {
        printSeparator("Testing all()");
        cv.Scalar scalar = await cv.Scalar.all(3.0);
        debugPrint("Scalar.all(3.0): " + scalar.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }

      // clone()
      try {
        printSeparator("Testing clone()");
        cv.Scalar origin = new cv.Scalar.fromArray([1, 2, 3, 4]);
        debugPrint("Before clone() -> origin: " +
            origin.toString() +
            " -> HashCode: " +
            origin.hashCode.toString());

        cv.Scalar cloned = await origin.clone();
        debugPrint("After clone() -> cloned: " +
            cloned.toString() +
            " -> HashCode: " +
            cloned.hashCode.toString());

        bool isHashEquals = origin.hashCode == cloned.hashCode;
        debugPrint("isHashEquals: " + isHashEquals.toString());

        debugPrint("euquals operator: " + (origin == cloned).toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }

      // mul(Scalar it)
      try {
        printSeparator("Testing mul(Scalar it)");
        cv.Scalar origin = new cv.Scalar.fromArray([1, 2, 3, 4]);
        debugPrint("Before mul() -> origin: " + origin.toString());

        cv.Scalar multiplied = await origin.mul(origin);
        debugPrint("After mul() -> multiplied: " + multiplied.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }

      // mul(Scalar it, double scale)
      try {
        printSeparator("Testing mul(Scalar it, double scale)");
        cv.Scalar origin = new cv.Scalar.fromArray([1, 2, 3, 4]);
        debugPrint("Before mul() -> origin: " + origin.toString());

        cv.Scalar multiplied = await origin.mul(origin, 2.0);
        debugPrint("After mul() -> multiplied: " + multiplied.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }

      // conj()
      try {
        printSeparator("Testing conj()");
        cv.Scalar origin = new cv.Scalar.fromArray([1, 2, 3, 4]);
        debugPrint("Before conj() -> origin: " + origin.toString());

        cv.Scalar conjed = await origin.conj();
        debugPrint("After conj() -> conjed: " + conjed.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }

      // isReal()
      try {
        printSeparator("Testing isReal()");
        cv.Scalar scalar = new cv.Scalar(v0: 0, v1: 0, v2: 0 /*,v3: 0*/);
        bool result = await scalar.isReal();
        debugPrint("scalar.isReal(): " + result.toString());
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
      //____ End temp tests*/
    }
  }

  void printSeparator(String s) {
    print("\n--------------" + s + "--------------");
  }
}
