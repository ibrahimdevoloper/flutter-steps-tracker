// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'steps_number.g.dart';

@JsonSerializable()
class StepsNumber {
  @JsonKey(name: 'at_step')
  double atStep;
  @JsonKey(name: 'timestamp',toJson: millisecondsToTimestamp, fromJson: timestampToMilliseconds)
  int timestamp;
  @JsonKey(name: 'points_added')
  double pointsAdded;
  @JsonKey(name: 'description')
  String? description;


  factory StepsNumber.fromJson(Map<String, dynamic> json) => _$StepsNumberFromJson(json);

  Map<String, dynamic> toJson() => _$StepsNumberToJson(this);

  StepsNumber(this.atStep, this.timestamp, this.pointsAdded,this.description);

  static Timestamp millisecondsToTimestamp(int milliseconds) {
    return Timestamp.fromMillisecondsSinceEpoch(milliseconds);
  }
  static int timestampToMilliseconds(Timestamp timestamp){
    return timestamp.millisecondsSinceEpoch;
  }
}
