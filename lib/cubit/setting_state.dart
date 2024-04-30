import 'package:equatable/equatable.dart';

import '../model/model.dart';
import 'cubit.dart';

class SettingState extends Equatable {
  final List<AuthModel> authModel;
  final List<SettingModel> settingModel;
  final String username;
  final String photo;
  final String name;
  final String error;
  final Status status;

  const SettingState({
    this.authModel = const [],
    this.settingModel = const [],
    this.username = '',
    this.photo = '',
    this.name = '',
    this.error = '',
    this.status = Status.initial,
  });

  SettingState copyWith({
    List<AuthModel>? authModel,
    List<SettingModel>? settingModel,
    String? username,
    String? photo,
    String? name,
    String? error,
    Status? status,
  }) {
    return SettingState(
      authModel: authModel ?? this.authModel,
      settingModel: settingModel ?? this.settingModel,
      username: username ?? this.username,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [authModel, settingModel, username, photo, name, error, status];
}
