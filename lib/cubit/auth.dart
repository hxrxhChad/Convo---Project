// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../model/index.dart';
import '../service/index.dart';
import '../utils/index.dart';
import 'index.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  late StreamSubscription<List<AuthModel>> authModelSubscription;
  final AuthService authService = AuthService();

  AuthCubit() : super(const AuthState()) {
    _streamAuthList();
  }

  void _streamAuthList() {
    authModelSubscription = authService.getAuthModel().listen(
      (authModelList) {
        setAuthModel(authModelList);
      },
      onError: (error) {
        debugPrint('Error fetching authModel results: $error');
      },
    );
  }

  @override
  Future<void> close() {
    authModelSubscription.cancel();
    return super.close();
  }

  Future<void> updateAuth() async {
    List<AuthModel> self =
        state.authModel.where((auth) => auth.authId == state.authId).toList();
    setStatus(Status.loading);
    await authService.updateUserInfo(
      email: state.emailId != '' ? state.emailId : self[0].email,
      photo: state.photo != '' ? state.photo : self[0].photo,
      name: state.name != '' ? state.name : self[0].name,
      username: state.username != '' ? state.username : self[0].username,
    );
    setStatus(Status.initial);
  }

  Future<void> addImage() async {
    String? image = await uploadPhoto();
    setPhoto(image!);
  }

  Future<void> LOGIN() async {
    setStatus(Status.loading);
    User? user = await authService.signInWithGoogle();
    if (user != null) {
      setAuthId(user.uid);
      setStatus(Status.success);
      debugPrint('during login -> ${state.authId}');
    } else {
      setError('Failed to sign in with Google');
      setStatus(Status.error);
    }
  }

  Future<void> SIGNOUT() async {
    setStatus(Status.loading);
    await authService.signOut();
    setAuthId('');
    setStatus(Status.initial);
  }

  // Setter and getter methods for authModel
  void setAuthModel(List<AuthModel> authModel) =>
      emit(state.copyWith(authModel: authModel));

  List<AuthModel> get authModel => state.authModel;

  // Setter and getter methods for authId
  void setAuthId(String authId) => emit(state.copyWith(authId: authId));

  String get authId => state.authId;

  // Setter and getter methods for username
  void setUsername(String username) => emit(state.copyWith(username: username));

  String get username => state.username;

  // Setter and getter methods for emailId
  void setEmailId(String emailId) => emit(state.copyWith(emailId: emailId));

  String get emailId => state.emailId;

  // Setter and getter methods for name
  void setName(String name) => emit(state.copyWith(name: name));

  String get name => state.name;

  // Setter and getter methods for photo
  void setPhoto(String photo) => emit(state.copyWith(photo: photo));

  String get photo => state.photo;

  // Setter and getter methods for error
  void setError(String error) => emit(state.copyWith(error: error));

  String get error => state.error;

  // Setter and getter methods for status
  void setStatus(Status status) => emit(state.copyWith(status: status));

  Status get status => state.status;

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
