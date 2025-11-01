import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'crop.g.dart';

@JsonSerializable()
class Crop {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  final String name;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime plantingDate;

  Crop({this.id, required this.name, required this.plantingDate});

  factory Crop.fromFirestore(DocumentSnapshot doc) {
    return Crop.fromJson(doc.data() as Map<String, dynamic>)..id = doc.id;
  }

  factory Crop.fromJson(Map<String, dynamic> json) => _$CropFromJson(json);

  Map<String, dynamic> toJson() => _$CropToJson(this);
}

DateTime _dateTimeFromTimestamp(Timestamp timestamp) => timestamp.toDate();
Timestamp _dateTimeToTimestamp(DateTime dateTime) => Timestamp.fromDate(dateTime);
