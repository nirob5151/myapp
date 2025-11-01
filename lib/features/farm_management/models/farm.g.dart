// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farm _$FarmFromJson(Map<String, dynamic> json) => Farm(
  name: json['name'] as String,
  location: json['location'] as String,
  crops: (json['crops'] as List<dynamic>)
      .map((e) => Crop.fromJson(e as Map<String, dynamic>))
      .toList(),
  ownerId: json['ownerId'] as String,
);

Map<String, dynamic> _$FarmToJson(Farm instance) => <String, dynamic>{
  'name': instance.name,
  'location': instance.location,
  'crops': instance.crops.map((e) => e.toJson()).toList(),
  'ownerId': instance.ownerId,
};
