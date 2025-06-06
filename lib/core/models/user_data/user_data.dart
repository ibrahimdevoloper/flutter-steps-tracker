// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: 'user_id')
  String id;
  @JsonKey(defaultValue: "")
  String docId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'redeemed_points')
  double redeemedPoints;
  @JsonKey(name: 'remaining_points')
  double remainingPoints;
  @JsonKey(name: 'step_count')
  double stepCount;
  @JsonKey(name: 'total_points')
  double totalPoints;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, Object?> toJson() => _$UserDataToJson(this);

  UserData(this.id, this.docId, this.name, this.email, this.redeemedPoints,
      this.remainingPoints, this.stepCount, this.totalPoints);
}
