import 'package:json_annotation/json_annotation.dart';

part 'crop.g.dart';

@JsonSerializable()
class Crop {
  final String? id;
  final String name;
  final String plantingDate;
  final String harvestDate;
  final String farmId;

  Crop({
    this.id,
    required this.name,
    required this.plantingDate,
    required this.harvestDate,
    required this.farmId,
  });

  factory Crop.fromJson(Map<String, dynamic> json) => _$CropFromJson(json);

  Map<String, dynamic> toJson() => _$CropToJson(this);
}
