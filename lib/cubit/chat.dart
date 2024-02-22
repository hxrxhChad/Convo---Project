// ignore_for_file: avoid_print

import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model.dart';
import '../service/service.dart';
import 'cubit.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService = ChatService();
  late StreamSubscription<List<AuthModel>> authModelSubscription;
  late StreamSubscription<List<ChatModel>> chatModelSubscription;

  ChatCubit() : super(const ChatState()) {
    streamAuthList();
    streamChatList();
  }

  //
  void streamAuthList() {
    authModelSubscription = chatService.getAuthModel().listen((authModelList) {
      // Update state with the filtered authModelList
      setAuthModelList(authModelList);
    }, onError: (error) {
      print('Error fetching authModel results: $error');
    });
  }

  void streamChatList() {
    chatModelSubscription = chatService.getChatModel().listen((chatModelList) {
      // Update state with the filtered ChatModelList
      setChatModelList(chatModelList);
    }, onError: (error) {
      print('Error fetching ChatModel results: $error');
    });
  }

  @override
  Future<void> close() {
    // Cancel the subscription when the Cubit is closed
    authModelSubscription.cancel();
    chatModelSubscription.cancel();
    return super.close();
  }

  // Future<void> onSearchTileTap(authId) async {
  //   String chatId = await chatService.getChatId(
  //       authId, FirebaseAuth.instance.currentUser!.uid);
  //   if (chatId != '') {}
  // }

  void setAuthModelList(List<AuthModel> authModelList) =>
      emit(state.copyWith(authModelList: authModelList));
  void setChatModelList(List<ChatModel> chatModelList) =>
      emit(state.copyWith(chatModelList: chatModelList));
  void setKeyword(String keyword) => emit(state.copyWith(keyword: keyword));
  void setMode(String mode) => emit(state.copyWith(mode: mode));
  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  List<AuthModel> get authModelList => state.authModelList;
  List<ChatModel> get chatModelList => state.chatModelList;
  String get keyword => state.keyword;
  String get mode => state.mode;
  String get error => state.error;
  Status get status => state.status;
}

/*
error
status

*/
