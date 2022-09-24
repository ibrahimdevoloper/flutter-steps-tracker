// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
      json['brand'] as String,
      json['image_url'] as String,
      json['name_ar'] as String,
      json['name_en'] as String,
      (json['redeem_points'] as num).toDouble(),
    );

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
      'brand': instance.brand,
      'image_url': instance.imageUrl,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'redeem_points': instance.redeemPoints,
    };
