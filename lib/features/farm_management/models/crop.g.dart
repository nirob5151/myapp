// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crop _$CropFromJson(Map<String, dynamic> json) => Crop(
  id: json['id'] as String?,
  name: json['name'] as String,
  plantingDate: json['plantingDate'] as String,
  harvestDate: json['harvestDate'] as String,
  farmId: json['farmId'] as String,
);

Map<String, dynamic> _$CropToJson(Crop instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'plantingDate': instance.plantingDate,
  'harvestDate': instance.harvestDate,
  'farmId': instance.farmId,
};
