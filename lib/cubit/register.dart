import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState()) {
    //
  }

  void setUsername(String username) => emit(state.copyWith(username: username));
  void setTaken(bool taken) => emit(state.copyWith(taken: taken));
  void setEmail(String email) => emit(state.copyWith(email: email));
  void setPassword(String password) => emit(state.copyWith(password: password));
  void setName(String name) => emit(state.copyWith(name: name));
  void setKey(int key) => emit(state.copyWith(key: key));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  String get username => state.username;
  bool get taken => state.taken;
  String get email => state.email;
  String get password => state.password;
  String get name => state.name;
  int get key => state.key;
  Status get status => state.status;
}
