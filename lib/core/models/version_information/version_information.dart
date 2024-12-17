// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'version_information.g.dart';

@JsonSerializable()
class VersionInformation {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  @JsonKey(name: 'version_number')
  final int versionNumber;
  @JsonKey(name: 'version_name')
  final String versionName;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(
    name: 'new_features_en',
    defaultValue: <String>[],
  )
  final List<String> newFeaturesEn;
  @JsonKey(
    name: 'bug_fixes_en',
    defaultValue: <String>[],
  )
  final List<String> bugFixesEn;
  @JsonKey(
    name: 'new_features_ar',
    defaultValue: <String>[],
  )
  final List<String> newFeaturesAr;
  @JsonKey(
    name: 'bug_fixes_ar',
    defaultValue: <String>[],
  )
  final List<String> bugFixesAr;
  @JsonKey(name: 'android_app_link')
  final String androidAppLink;
  @JsonKey(name: 'apple_app_link')
  final String appleAppLink;
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;
  @JsonKey(name: 'is_mandatory')
  final bool isMandatory;

  factory VersionInformation.fromJson(Map<String, dynamic> json) =>
      _$VersionInformationFromJson(json);

  Map<String, dynamic> toJson() => _$VersionInformationToJson(this);

  VersionInformation(
      this.versionNumber,
      this.versionName,
      this.releaseDate,
      this.newFeaturesEn,
      this.bugFixesEn,
      this.newFeaturesAr,
      this.bugFixesAr,
      this.androidAppLink,
      this.appleAppLink,
      this.descriptionEn,
      this.descriptionAr,
      this.isMandatory);
}
