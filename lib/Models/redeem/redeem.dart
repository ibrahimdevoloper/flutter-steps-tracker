// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'redeem.g.dart';

@JsonSerializable()
class Redeem {
  @JsonKey(name: 'reward_id')
  String rewardId;
  @JsonKey(name: 'brand')
  String brand;
  @JsonKey(name: 'image_url')
  String imageUrl;
  @JsonKey(name: 'name_ar')
  String nameAr;
  @JsonKey(name: 'name_en')
  String nameEn;
  @JsonKey(name: 'redeem_points')
  double redeemPoints;



  factory Redeem.fromJson(Map<String, dynamic> json) => _$RedeemFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemToJson(this);

  Redeem(this.rewardId, this.brand, this.imageUrl, this.nameAr, this.nameEn,this.redeemPoints);
}
