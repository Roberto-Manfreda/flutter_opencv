import 'package:flutter/services.dart';

abstract class DataExchanger {
  static MethodChannel _channel = MethodChannel("flutter_opencv");
  Map<String, dynamic> _dataMap = Map();

  static Map<String, dynamic> getDataStatically(String className, [dynamic arguments = ""]){
    Map<String, dynamic> dataMap = Map();
    dataMap["class"] = className;
    dataMap["arguments"] = arguments;
    return dataMap;
  }

  void setDataMap(String className, [dynamic arguments = ""]) {
    _dataMap = getDataStatically(className, arguments);
  }

  String getObjectAsJson();

  Map<String, dynamic> get dataMap => _dataMap;

  static MethodChannel get channel => _channel;
}