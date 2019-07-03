/* This is free and unencumbered software released into the public domain. */
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scalar.g.dart';

/// Class for a 4-element vector derived from [Vec].
///
/// See: https://docs.opencv.org/3.4.3/d1/da0/classcv_1_1Scalar__.html
///
/// See: http://bytedeco.org/javacpp-presets/opencv/apidocs/org/opencv/core/Scalar.html
@JsonSerializable()
class Scalar {

  // Method channel__
  static const MethodChannel _channel = MethodChannel('flutter_opencv');

  //Fields__
  List<double> val = [];

  Scalar({double v0, double v1, double v2, double v3}) {
    null != v0 ? val.add(v0) : val.add(0);
    null != v1 ? val.add(v1) : val.add(0);
    null != v2 ? val.add(v2) : val.add(0);
    null != v3 ? val.add(v3) : val.add(0);
  }

  Scalar.fromArray(this.val);

  // Methods__
  Future<void> set(List<double> vals) async {
    String json = await _channel.invokeMethod("set", vals);
    Map scalarMap = jsonDecode(json);
    Scalar scalar = Scalar.fromJson(scalarMap);
    this.val = scalar.val;
  }

  static Future<Scalar> all(double value) async {
    String json = await _channel.invokeMethod("all", value);
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<Scalar> clone() async {
    String json = await _channel.invokeMethod("clone", this.toJson().toString());
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<Scalar> mul(Scalar it, [double scale]) async {
    Map<String, String> parameters = new Map();
    parameters["json"] = this.toJson().toString();
    if (null != scale) parameters["scale"] = scale.toString();
    String json = await _channel.invokeMethod("mul", parameters);
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<Scalar> conj() async {
    String json = await _channel.invokeMethod("conj", this.toJson().toString());
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<bool> isReal() async {
    return await _channel.invokeMethod("isReal", this.val);
  }

  // Json serialization/deserialization__
  factory Scalar.fromJson(Map<String, dynamic> json) => _$ScalarFromJson(json);
  
  Map<String, dynamic> toJson() => _$ScalarToJson(this);

  // Overrides__
  @override
  String toString() {
    return 'Scalar{val: $val}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Scalar &&
              runtimeType == other.runtimeType &&
              val == other.val;

  @override
  int get hashCode => val.hashCode;
}
