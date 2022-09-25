// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'reward.g.dart';

@JsonSerializable()
class Reward {
  @JsonKey(ignore: true)
  String? id;
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


  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  Map<String, dynamic> toJson() => _$RewardToJson(this);

  Reward(this.brand, this.imageUrl, this.nameAr, this.nameEn,this.redeemPoints);
}
