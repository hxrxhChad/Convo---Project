// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel extends Equatable {
  String? authId;
  String? username;
  String? email;
  String? password;
  String? name;
  int? time;
  String? gender;
  String? photo;

  AuthModel({
    this.authId,
    this.username,
    this.email,
    this.password,
    this.name,
    this.time,
    this.gender,
    this.photo,
  });

  AuthModel copyWith({
    String? authId,
    String? username,
    String? email,
    String? password,
    String? name,
    int? time,
    String? gender,
    String? photo,
  }) =>
      AuthModel(
        authId: authId ?? this.authId,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        time: time ?? this.time,
        gender: gender ?? this.gender,
        photo: photo ?? this.photo,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        authId: json["authId"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        time: json["time"],
        gender: json["gender"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "authId": authId,
        "username": username,
        "email": email,
        "password": password,
        "name": name,
        "time": time,
        "gender": gender,
        "photo": photo,
      };

  @override
  List<Object?> get props =>
      [authId, username, email, password, name, time, gender, photo];
}
