import 'package:equatable/equatable.dart';

import 'cubit.dart';

class AuthState extends Equatable {
  final String authId;
  final String email;
  final String password;
  final String error;
  final Status status;

  const AuthState(
      {this.authId = '',
      this.email = '',
      this.password = '',
      this.error = '',
      this.status = Status.initial});

  AuthState copyWith(
      {String? authId,
      String? email,
      String? password,
      String? error,
      Status? status}) {
    return AuthState(
      authId: authId ?? this.authId,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [authId, email, password, error, status];
}

/*
email
password
status
*/