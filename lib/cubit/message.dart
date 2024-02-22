import 'dart:async';

import 'package:chat_alpha_sept/utils/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model.dart';
import '../service/service.dart';
import 'cubit.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageService messageService = MessageService();

  late StreamSubscription<List<AuthModel>> senderAuthSubscription;
  late StreamSubscription<List<MessageModel>> messageSubscription;
  MessageCubit() : super(const MessageState()) {
    // streamSenderAuth();
    // streamMessage();
  }

  void streamSenderAuth() {
    debugPrint('the chatid is -> ${state.chatId}');
    if (state.chatId != '') {
      senderAuthSubscription =
          messageService.getSenderAuth(state.chatId).listen((authModelList) {
        setSenderAuthModelList(authModelList);
      }, onError: (error) {
        debugPrint('Error fetching authModel results: $error');
      });
      debugPrint(state.senderAuthModelList.toString());
    } else {
      debugPrint('The chatId is empty LoL');
    }
  }

  void streamMessage() {}

  void sendTextMessage() {
    messageService.sendTextMessage(state.chatId, state.content);
  }

  Future<void> setImageContent() async {
    String? image = await uploadPhoto();
    setContent(image!);
  }

  Future<void> sendImageMessage() async {
    await setImageContent();
    await messageService.sendImageMessage(state.chatId, state.content);
  }

  @override
  Future<void> close() {
    // Cancel the subscription when the Cubit is closed
    senderAuthSubscription.cancel();
    messageSubscription.cancel();
    return super.close();
  }

  void setContent(String content) => emit(state.copyWith(content: content));
  void setSenderAuthModelList(List<AuthModel> senderAuthModelList) =>
      emit(state.copyWith(senderAuthModelList: senderAuthModelList));
  void setMessageList(List<MessageModel> messageList) =>
      emit(state.copyWith(messageList: messageList));
  void setChatId(String chatId) => emit(state.copyWith(chatId: chatId));
  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  String get content => state.content;
  List<AuthModel> get senderAuthModelList => state.senderAuthModelList;
  List<MessageModel> get messageList => state.messageList;
  String get chatId => state.chatId;
  String get error => state.error;
  Status get status => state.status;
}
