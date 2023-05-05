// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'privacy_and_terms.g.dart';

@JsonSerializable()
class PrivacyAndTerms {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  @JsonKey(name: 'title_en')
  String titleEn;
  @JsonKey(name: 'title_ar')
  String titleAr;
  @JsonKey(name: 'content_en')
  String contentEn;
  @JsonKey(name: 'content_ar')
  String contentAr;

  factory PrivacyAndTerms.fromJson(Map<String, dynamic> json) =>
      _$PrivacyAndTermsFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyAndTermsToJson(this);

  PrivacyAndTerms(this.titleEn, this.titleAr, this.contentEn, this.contentAr);
}
