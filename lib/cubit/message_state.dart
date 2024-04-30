import 'package:equatable/equatable.dart';

import '../model/model.dart';
import 'cubit.dart';

class MessageState extends Equatable {
  final String content;
  final List<AuthModel> senderAuthModelList;
  final List<MessageModel> messageList;
  final String chatId;
  final String error;
  final Status status;

  const MessageState({
    this.content = '',
    this.senderAuthModelList = const [],
    this.messageList = const [],
    this.chatId = '',
    this.error = '',
    this.status = Status.initial,
  });

  MessageState copyWith({
    String? content,
    List<AuthModel>? senderAuthModelList,
    List<MessageModel>? messageList,
    String? chatId,
    String? error,
    Status? status,
  }) {
    return MessageState(
      content: content ?? this.content,
      senderAuthModelList: senderAuthModelList ?? this.senderAuthModelList,
      messageList: messageList ?? this.messageList,
      chatId: chatId ?? this.chatId,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [content, senderAuthModelList, messageList, chatId, error, status];
}
