// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

SettingModel settingModelFromJson(String str) =>
    SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel extends Equatable {
  String? privacyPolicy;
  String? termsOfService;
  String? communityGuidelines;
  String? support;

  SettingModel({
    this.privacyPolicy,
    this.termsOfService,
    this.communityGuidelines,
    this.support,
  });

  SettingModel copyWith({
    String? privacyPolicy,
    String? termsOfService,
    String? communityGuidelines,
    String? support,
  }) =>
      SettingModel(
        privacyPolicy: privacyPolicy ?? this.privacyPolicy,
        termsOfService: termsOfService ?? this.termsOfService,
        communityGuidelines: communityGuidelines ?? this.communityGuidelines,
        support: support ?? this.support,
      );

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        privacyPolicy: json["privacy_policy"],
        termsOfService: json["terms_of_service"],
        communityGuidelines: json["community_guidelines"],
        support: json["support"],
      );

  Map<String, dynamic> toJson() => {
        "privacy_policy": privacyPolicy,
        "terms_of_service": termsOfService,
        "community_guidelines": communityGuidelines,
        "support": support,
      };

  @override
  List<Object?> get props =>
      [privacyPolicy, termsOfService, communityGuidelines, support];
}
