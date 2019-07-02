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

  //Fields__
  List<double> _val = [];

  // Constructor
  Scalar({double v0, double v1, double v2, double v3}) {
    null != v0 ? _val.add(v0) : _val.add(0);
    null != v1 ? _val.add(v1) : _val.add(0);
    null != v2 ? _val.add(v2) : _val.add(0);
    null != v3 ? _val.add(v3) : _val.add(0);
  }

  // Methods__
  static Future<Scalar> all(double value) async {
    List<dynamic> result = await _channel.invokeMethod("all", value);
    return new Scalar(v0: result[0], v1: result[1], v2: result[2], v3: result[3]);
  }

  Future<void> set(List<double> vals) async {
    await _channel.invokeMethod("set", vals).then((result) {
      _val = new List();

      for (double d in result) {
        _val.add(d);
      }
    });
  }

  Future<bool> isReal() async {
    return await _channel.invokeMethod("isReal", _val);
  }

  // Overrides__
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
