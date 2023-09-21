import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Future<void> signOut() async {
    setStatus(Status.loading);
    try {
      await FirebaseAuth.instance.signOut();
      setStatus(Status.success);
    } catch (e) {
      setStatus(Status.error);
      setError(e.toString());
    }
  }

  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  String get error => state.error;
  Status get status => state.status;
}

class SettingsState extends Equatable {
  final String error;
  final Status status;

  const SettingsState({this.error = '', this.status = Status.initial});

  SettingsState copyWith({String? error, Status? status}) {
    return SettingsState(
        error: error ?? this.error, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [error, status];
}
