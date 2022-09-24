// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['user_id'] as String,
      json['name'] as String,
      (json['redeemed_points'] as num).toDouble(),
      (json['remaining_points'] as num).toDouble(),
      (json['step_count'] as num).toDouble(),
      (json['total_points'] as num).toDouble(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'user_id': instance.id,
      'name': instance.name,
      'redeemed_points': instance.redeemedPoints,
      'remaining_points': instance.remainingPoints,
      'step_count': instance.stepCount,
      'total_points': instance.totalPoints,
    };
