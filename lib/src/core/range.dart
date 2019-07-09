/* This is free and unencumbered software released into the public domain. */

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../data_exchanger.dart';

part 'range.g.dart';

/// Class specifying a continuous subsequence (slice) of a sequence.
///
/// See: https://docs.opencv.org/3.4.3/da/d35/classcv_1_1Range.html
///
/// See: http://bytedeco.org/javacpp-presets/opencv/apidocs/org/opencv/core/Range.html

@JsonSerializable()
class Range extends DataExchanger {
  // Fields__
  int start, end;

  // Constructors__
  Range([int s, int e]) {
    null != s ? start = s : s = 0;
    null != e ? start = e : e = 0;
  }

  Range.fromArray(List<int> vals) {
    if (null != vals) {
      start = vals.length > 0 ? vals[0] : 0;
      end = vals.length > 1 ? vals[1] : 0;
    } else {
      start = 0;
      end = 0;
    }
  }

  // Functions__
  Future<void> set(List<int> vals) async {
    setDataMap("Range", vals);
    String json = await DataExchanger.channel.invokeMethod("set", dataMap);
    Map rangeMap = jsonDecode(json);
    Range range = Range.fromJson(rangeMap);
    start = range.start;
    end = range.end;
  }

  // Json de/serialization__
  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

  Map<String, dynamic> toJson() => _$RangeToJson(this);

  // Overrides__
  @override
  String getObjectAsJson() {
    return this.toJson().toString();
  }

  @override
  String toString() {
    return 'Range{start: $start, end: $end}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Range &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
