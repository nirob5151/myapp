import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/farm_management/models/crop.dart';

part 'farm.g.dart';

@JsonSerializable(explicitToJson: true)
class Farm {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  final String name;
  final String location;
  final List<Crop> crops;
  final String ownerId;

  Farm({this.id, required this.name, required this.location, required this.crops, required this.ownerId});

  factory Farm.fromFirestore(DocumentSnapshot doc) {
    return Farm.fromJson(doc.data() as Map<String, dynamic>)..id = doc.id;
  }

  factory Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);

  Map<String, dynamic> toJson() => _$FarmToJson(this);
}
