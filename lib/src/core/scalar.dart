/* This is free and unencumbered software released into the public domain. */

import 'dart:async';

import 'package:flutter/services.dart';

/// Class for a 4-element vector derived from [Vec].
///
/// See: https://docs.opencv.org/3.4.3/d1/da0/classcv_1_1Scalar__.html
///
/// See: http://bytedeco.org/javacpp-presets/opencv/apidocs/org/opencv/core/Scalar.html
class Scalar {

  // Method channel
  static const MethodChannel _channel = MethodChannel('flutter_opencv');

  //Fields
  List<double> _val = [];

  // Constructor
  Scalar({double v0, double v1, double v2, double v3}) {
    null != v0 ? _val.add(v0) : _val.add(0);
    null != v1 ? _val.add(v1) : _val.add(0);
    null != v2 ? _val.add(v2) : _val.add(0);
    null != v3 ? _val.add(v3) : _val.add(0);
  }

  // Methods
  Future<void> set(List<double> vals) async {
    Completer completer = new Completer();

    List<double> list = new List();
    list.addAll(vals);

    await _channel.invokeMethod("set", list).then((result) {
      _val = new List();

      for (double d in result) {
        print(d);
        _val.add(d);
      }

    });
  }

  Future<bool> isReal() async {
    List<double> l = new List();
    l.addAll(_val);
    return await _channel.invokeMethod("isReal", l) as bool;
  }

  @override
  String toString() {
    return 'Scalar{_val: $_val}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Scalar &&
              runtimeType == other.runtimeType &&
              _val == other._val;

  @override
  int get hashCode => _val.hashCode;
}
