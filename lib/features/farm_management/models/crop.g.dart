// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crop _$CropFromJson(Map<String, dynamic> json) => Crop(
  name: json['name'] as String,
  plantingDate: _dateTimeFromTimestamp(json['plantingDate'] as Timestamp),
);

Map<String, dynamic> _$CropToJson(Crop instance) => <String, dynamic>{
  'name': instance.name,
  'plantingDate': _dateTimeToTimestamp(instance.plantingDate),
};
