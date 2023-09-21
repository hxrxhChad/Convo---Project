import 'dart:convert';

import 'package:equatable/equatable.dart';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register extends Equatable {
  String? id;
  final String username;
  final String email;
  final String password;
  final String name;
  final String time;
  final String photo;
  final String cover;

  Register({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.time,
    required this.photo,
    required this.cover,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        time: json["time"],
        photo: json["photo"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "name": name,
        "time": time,
        "photo": photo,
        "cover": cover,
      };

  @override
  List<Object?> get props =>
      [id, username, email, password, name, time, photo, cover];
}
