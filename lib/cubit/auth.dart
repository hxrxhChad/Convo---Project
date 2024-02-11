// ignore_for_file: non_constant_identifier_names

import 'package:chat_alpha_sept/cubit/auth_state.dart';
import 'package:chat_alpha_sept/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'cubit.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final authService = AuthService();
  AuthCubit() : super(const AuthState()) {
    //
    // if (ChatId != '') {
    //   _messageSubscription =
    //       messageService.getMessage(ChatId).listen((messages) {
    //     setMessageModel(messages);
    //   });
    // }
  }

  // @override
  // Future<void> close() {
  //   _messageSubscription.cancel();
  //   return super.close();
  // }

  Future<void> LOGIN() async {
    if (authService.loginFormError(email, password) == 'null') {
      debugPrint(email);
      debugPrint(password);
      setStatus(Status.loading);
      try {
        final uid = await authService.login(email, password);
        setAuthId(uid!);
        setStatus(Status.success);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          setStatus(Status.error);
          setError('Please provide a valid email');
          return;
        } else if (e.code == 'user-disabled') {
          setStatus(Status.error);
          setError('The account has been disabled');
          return;
        } else if (e.code == 'user-not-found') {
          setStatus(Status.error);
          setError('Provided user account does not exist');
          return;
        } else if (e.code == 'wrong-password') {
          setStatus(Status.error);
          setError('You provided a wrong password');
          return;
        }
      }
    } else {
      setStatus(Status.error);
      setError(authService.loginFormError(email, password));
      return;
    }
  }

  Future<void> SIGNOUT() async {
    setStatus(Status.loading);
    try {
      await FirebaseAuth.instance.signOut();
      setAuthId('');
      setStatus(Status.success);
    } catch (e) {
      setStatus(Status.error);
      setError(e.toString());
    }
  }

  void setAuthId(String authId) => emit(state.copyWith(authId: authId));
  void setEmail(String email) => emit(state.copyWith(email: email));
  void setPassword(String password) => emit(state.copyWith(password: password));
  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  String get authId => state.authId;
  String get email => state.email;
  String get password => state.password;
  String get error => state.error;
  Status get status => state.status;

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return AuthState(
      authId: json['authId'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      error: json['error'] as String,
      status: Status.values[json['status'] as int],
    );
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    return {
      'authId': state.authId,
      'email': state.email,
      'password': state.password,
      'error': state.error,
      'status': state.status.index,
    };
  }
}
