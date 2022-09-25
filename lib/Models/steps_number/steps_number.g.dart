// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepsNumber _$StepsNumberFromJson(Map<String, dynamic> json) => StepsNumber(
      (json['at_step'] as num).toDouble(),
      StepsNumber.timestampToMilliseconds(json['timestamp'] as Timestamp),
      (json['points_added'] as num).toDouble(),
      json['description'] as String?,
    );

Map<String, dynamic> _$StepsNumberToJson(StepsNumber instance) =>
    <String, dynamic>{
      'at_step': instance.atStep,
      'timestamp': StepsNumber.millisecondsToTimestamp(instance.timestamp),
      'points_added': instance.pointsAdded,
      'description': instance.description,
    };
