// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Redeem _$RedeemFromJson(Map<String, dynamic> json) => Redeem(
      json['reward_id'] as String,
      json['brand'] as String,
      json['image_url'] as String,
      json['name_ar'] as String,
      json['name_en'] as String,
      (json['redeem_points'] as num).toDouble(),
    );

Map<String, dynamic> _$RedeemToJson(Redeem instance) => <String, dynamic>{
      'reward_id': instance.rewardId,
      'brand': instance.brand,
      'image_url': instance.imageUrl,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'redeem_points': instance.redeemPoints,
    };
