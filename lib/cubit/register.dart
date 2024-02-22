// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:chat_alpha_sept/service/auth.dart';
import 'package:chat_alpha_sept/utils/image_uploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final authService = AuthService();
  late StreamSubscription<bool>? _takenSubscription;

  RegisterCubit() : super(const RegisterState()) {
    if (state.username != '') {
      _takenSubscription = authService.getTaken(state.username).listen((taken) {
        setTaken(taken);
      });
    }
  }
  @override
  Future<void> close() {
    _takenSubscription?.cancel();
    return super.close();
  }

  Future<void> REGISTER() async {
    String formError =
        authService.registerFormError(username, photo, email, password, name);
    if (formError == 'null') {
      setStatus(Status.loading);
      try {
        final user = await authService.register(email, password);
        if (user != null) {
          try {
            await authService.registerCloud(username, email, password, name,
                photo, DateTime.now().millisecondsSinceEpoch);
            setStatus(Status.success);
          } catch (e) {
            setStatus(Status.error);
            setError('Unable to Save the Registered Data');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          setStatus(Status.error);
          setError('Please provide a valid email');
          return;
        } else if (e.code == 'email-already-in-use') {
          setStatus(Status.error);
          setError('The email address is already in use by another account');
          return;
        } else if (e.code == 'operation-not-allowed') {
          setStatus(Status.error);
          setError('Provided operation is not allowed');
          return;
        } else if (e.code == 'weak-password') {
          setStatus(Status.error);
          setError(
              'You provided a very weak password, Please try again with a strong password');
          return;
        }
      }
    } else {
      setStatus(Status.error);
      setError(formError);
      return;
    }
  }

  Future<void> addImage() async {
    String? image = await uploadPhoto();
    setPhoto(image!);
  }

  void setUsername(String username) => emit(state.copyWith(username: username));
  void setTaken(bool taken) => emit(state.copyWith(taken: taken));
  void setEmail(String email) => emit(state.copyWith(email: email));
  void setPassword(String password) => emit(state.copyWith(password: password));
  void setName(String name) => emit(state.copyWith(name: name));
  void setPhoto(String photo) => emit(state.copyWith(photo: photo));
  void setKey(int key) => emit(state.copyWith(key: key));
  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  String get username => state.username;
  bool get taken => state.taken;
  String get email => state.email;
  String get password => state.password;
  String get name => state.name;
  String get photo => state.photo;
  int get key => state.key;
  String get error => state.error;
  Status get status => state.status;
}
