import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String? authId;
  String? username;
  String? email;
  String? name;
  int? accountCreationTime;
  String? photo;

  AuthModel({
    this.authId,
    this.username,
    this.email,
    this.name,
    this.accountCreationTime,
    this.photo,
  });

  AuthModel copyWith({
    String? authId,
    String? username,
    String? email,
    String? name,
    int? accountCreationTime,
    String? photo,
  }) =>
      AuthModel(
        authId: authId ?? this.authId,
        username: username ?? this.username,
        email: email ?? this.email,
        name: name ?? this.name,
        accountCreationTime: accountCreationTime ?? this.accountCreationTime,
        photo: photo ?? this.photo,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        authId: json["authId"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        accountCreationTime: json["accountCreationTime"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "authId": authId,
        "username": username,
        "email": email,
        "name": name,
        "accountCreationTime": accountCreationTime,
        "photo": photo,
      };
}
