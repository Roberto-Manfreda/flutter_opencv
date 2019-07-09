import 'package:flutter/services.dart';

abstract class DataExchanger {
  // Static Fields__
  static MethodChannel _channel = MethodChannel("flutter_opencv");
  // Fields__
  Map<String, dynamic> _dataMap = Map();

  // Static functions__
  static Map<String, dynamic> getDataStatically(String className, [dynamic arguments = ""]){
    Map<String, dynamic> dataMap = Map();
    dataMap["class"] = className;
    dataMap["arguments"] = arguments;
    return dataMap;
  }

  // Functions
  void setDataMap(String className, [dynamic arguments = ""]) {
    _dataMap = getDataStatically(className, arguments);
  }

  // Functions to override
  String getObjectAsJson();

  // Getters
  Map<String, dynamic> get dataMap => _dataMap;
  static MethodChannel get channel => _channel;
}