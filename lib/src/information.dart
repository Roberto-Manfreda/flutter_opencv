import 'data_exchanger.dart';

class Information extends DataExchanger {

  /// Returns full configuration-time `cmake` output.
  ///
  /// See: https://docs.opencv.org/3.4.3/db/de0/group__core__utils.html#ga0ae377100bc03ce22322926bba7fdbb5
  Future<String> getBuildInformation() async {
    setDataMap("Information");
    return await DataExchanger.channel.invokeMethod("getBuildInformation", dataMap);
  }

  /// Returns the library version string.
  ///
  /// For example, "3.4.3-dev".
  ///
  /// See: https://docs.opencv.org/3.4.3/db/de0/group__core__utils.html#gae87dff0eecfca4e5ec38ac06ee424980
  Future<String> getVersionString() async {
    setDataMap("Information");
    return await DataExchanger.channel.invokeMethod("getVersionString", dataMap);
  }

  @override
  String getObjectAsJson() {
    return "Not Implemented";
  }
}