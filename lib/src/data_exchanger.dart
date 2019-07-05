import 'package:flutter/services.dart';

class DataExchanger {
  MethodChannel _channel = MethodChannel("flutter_opencv");
  Map<String, dynamic> _map = Map();

  void setMapParams(String className, [dynamic arguments]) {
    _map["class"] = className;
    _map["arguments"] = arguments;
  }

  Map<String, dynamic> get map => _map;

  MethodChannel get channel => _channel;
}