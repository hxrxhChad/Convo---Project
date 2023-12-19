import 'package:equatable/equatable.dart';

import 'cubit.dart';

class RegisterState extends Equatable {
  final String username;
  final bool taken;
  final String email;
  final String password;
  final String name;
  final int key;
  final Status status;

  const RegisterState(
      {this.username = '',
      this.taken = false,
      this.email = '',
      this.password = '',
      this.name = '',
      this.key = 0,
      this.status = Status.initial});

  RegisterState copyWith(
      {String? username,
      bool? taken,
      String? email,
      String? password,
      String? name,
      int? key,
      Status? status}) {
    return RegisterState(
      username: username ?? this.username,
      taken: taken ?? this.taken,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      key: key ?? this.key,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [username, taken, email, password, name, key, status];
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