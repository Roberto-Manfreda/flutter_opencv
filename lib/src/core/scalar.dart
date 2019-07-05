/* This is free and unencumbered software released into the public domain. */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../data_exchanger.dart';

part 'scalar.g.dart';
/// Class for a 4-element vector derived from [Vec].
///
/// See: https://docs.opencv.org/3.4.3/d1/da0/classcv_1_1Scalar__.html
///
/// See: http://bytedeco.org/javacpp-presets/opencv/apidocs/org/opencv/core/Scalar.html
@JsonSerializable()
class Scalar extends DataExchanger {

  //Fields__
  List<double> val = [];

  // Constructors__
  Scalar({double v0, double v1, double v2, double v3}) {
    null != v0 ? val.add(v0) : val.add(0);
    null != v1 ? val.add(v1) : val.add(0);
    null != v2 ? val.add(v2) : val.add(0);
    null != v3 ? val.add(v3) : val.add(0);
  }

  Scalar.fromArray(this.val);

  // Methods__
  Future<void> set(List<double> vals) async {
    setMapParams("Scalar", vals);

    String json = await channel.invokeMethod("set", map);
    Map scalarMap = jsonDecode(json);
    Scalar scalar = Scalar.fromJson(scalarMap);
    this.val = scalar.val;
  }

  static Future<Scalar> all(double value) async {
    DataExchanger exchanger = DataExchanger();
    exchanger.setMapParams("Scalar", value);

    String json = await exchanger.channel.invokeMethod("all", exchanger.map);
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<Scalar> clone() async {
    setMapParams("Scalar", getObjAsJson());

    String json = await channel.invokeMethod("clone", map);
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<Scalar> mul(Scalar it, [double scale]) async {
    Map<String, String> parameters = new Map();
    parameters["json"] = this.toJson().toString();
    if (null != scale) parameters["scale"] = scale.toString();

    setMapParams("Scalar", parameters);

    String json = await channel.invokeMethod("mul", map);
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<Scalar> conj() async {
    setMapParams("Scalar", getObjAsJson());

    String json = await channel.invokeMethod("conj", map);
    Map scalarMap = jsonDecode(json);
    return Scalar.fromJson(scalarMap);
  }

  Future<bool> isReal() async {
    setMapParams("Scalar", this.val);
    return await channel.invokeMethod("isReal", map);
  }

  // Helpers__
  // TODO extends some other class


  String getObjAsJson() {
    return this.toJson().toString();
  }

  // Json de/serialization__
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