import 'package:equatable/equatable.dart';

import 'cubit.dart';

class RegisterState extends Equatable {
  final String username;
  final bool taken;
  final String email;
  final String password;
  final String name;
  final String photo;
  final int key;
  final String error;
  final Status status;

  const RegisterState(
      {this.username = '',
      this.taken = false,
      this.email = '',
      this.password = '',
      this.name = '',
      this.photo = '',
      this.key = 0,
      this.error = '',
      this.status = Status.initial});

  RegisterState copyWith(
      {String? username,
      bool? taken,
      String? email,
      String? password,
      String? name,
      String? photo,
      int? key,
      String? error,
      Status? status}) {
    return RegisterState(
      username: username ?? this.username,
      taken: taken ?? this.taken,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      key: key ?? this.key,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [username, taken, email, password, name, photo, key, error, status];
}

/*
username
taken?
email
password
name
key
status
*/