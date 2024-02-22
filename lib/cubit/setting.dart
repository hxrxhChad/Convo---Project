// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model.dart';
import '../service/service.dart';
import '../utils/utils.dart';
import 'cubit.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingService settingService = SettingService();
  late StreamSubscription<List<AuthModel>> authModelSubscription;
  late StreamSubscription<List<SettingModel>> settingModelSubscription;
  SettingCubit() : super(const SettingState()) {
    //
    streamAuthList();
    streamSettingList();
  }

  void streamAuthList() {
    authModelSubscription =
        settingService.getAuthModel().listen((authModelList) {
      // Update state with the filtered authModelList
      setAuthModel(authModelList);
    }, onError: (error) {
      debugPrint('Error fetching authModel results: $error');
    });
  }

  void streamSettingList() {
    settingModelSubscription =
        settingService.getSettingModel().listen((settingModelList) {
      // Update state with the filtered settingModelList
      setSettingModel(settingModelList);
    }, onError: (error) {
      debugPrint('Error fetching settingModel results: $error');
    });
  }

  @override
  Future<void> close() {
    // Cancel the subscription when the Cubit is closed
    authModelSubscription.cancel();
    settingModelSubscription.cancel();
    return super.close();
  }

  Future<void> updateSetting() async {
    setStatus(Status.loading);
    await settingService
        .updateUserProfile(
          authId: FirebaseAuth.instance.currentUser!.uid,
          username: state.username == ''
              ? state.authModel[0].username!
              : state.username,
          photoUrl: state.photo == '' ? state.authModel[0].photo! : state.photo,
          name: state.name == '' ? state.authModel[0].name! : state.name,
        )
        .whenComplete(() => setStatus(Status.initial));
  }

  Future<void> addImage() async {
    String? image = await uploadPhoto();
    setPhoto(image!);
  }

  List<AuthModel> get authModel => state.authModel;
  List<SettingModel> get settingModel => state.settingModel;
  String get username => state.username;
  String get photo => state.photo;
  String get name => state.name;
  String get error => state.error;
  Status get status => state.status;

  void setAuthModel(List<AuthModel> authModel) =>
      emit(state.copyWith(authModel: authModel));
  void setSettingModel(List<SettingModel> settingModel) =>
      emit(state.copyWith(settingModel: settingModel));
  void setUsername(String username) => emit(state.copyWith(username: username));
  void setPhoto(String photo) => emit(state.copyWith(photo: photo));
  void setName(String name) => emit(state.copyWith(name: name));
  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));
}
