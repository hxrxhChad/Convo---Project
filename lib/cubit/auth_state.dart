import 'package:equatable/equatable.dart';

import '../model/index.dart';

class AuthState extends Equatable {
  final List<AuthModel> authModel;
  final String authId;
  final String username;
  final String emailId;
  final String name;
  final String photo;
  final String error;
  final Status status;

  const AuthState({
    this.authModel = const [],
    this.authId = '',
    this.username = '',
    this.emailId = '',
    this.name = '',
    this.photo = '',
    this.error = '',
    this.status = Status.initial,
  });

  AuthState copyWith({
    List<AuthModel>? authModel,
    String? authId,
    String? username,
    String? emailId,
    String? name,
    String? photo,
    String? error,
    Status? status,
  }) {
    return AuthState(
      authModel: authModel ?? this.authModel,
      authId: authId ?? this.authId,
      username: username ?? this.username,
      emailId: emailId ?? this.emailId,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      authModel: (json['authModel'] as List<dynamic>?)
              ?.map((e) => AuthModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      authId: json['authId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      emailId: json['emailId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      error: json['error'] as String? ?? '',
      status: json['status'] != null
          ? Status.values[json['status'] as int]
          : Status.initial,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authModel': authModel.map((e) => e.toJson()).toList(),
      'authId': authId,
      'username': username,
      'emailId': emailId,
      'name': name,
      'photo': photo,
      'error': error,
      'status': status.index,
    };
  }

  @override
  List<Object?> get props => [
        authModel,
        authId,
        username,
        emailId,
        name,
        photo,
        error,
        status,
      ];
}

enum Status { initial, error, success, loading }
