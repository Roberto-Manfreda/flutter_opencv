// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scalar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scalar _$ScalarFromJson(Map<String, dynamic> json) {
  return Scalar()
    ..val = (json['val'] as List)?.map((e) => (e as num)?.toDouble())?.toList();
}

Map<String, dynamic> _$ScalarToJson(Scalar instance) =>
    <String, dynamic>{'val': instance.val};
