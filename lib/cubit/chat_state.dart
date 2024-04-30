import 'package:equatable/equatable.dart';

import '../model/model.dart';
import 'cubit.dart';

class ChatState extends Equatable {
  final List<AuthModel> authModelList;
  final List<ChatModel> chatModelList;
  final String keyword;
  final String mode;
  final String error;
  final Status status;

  const ChatState({
    this.authModelList = const [],
    this.chatModelList = const [],
    this.keyword = '',
    this.mode = 'chat',
    this.error = '',
    this.status = Status.initial,
  });

  ChatState copyWith({
    List<AuthModel>? authModelList,
    List<ChatModel>? chatModelList,
    String? keyword,
    String? mode,
    String? error,
    Status? status,
  }) {
    return ChatState(
      authModelList: authModelList ?? this.authModelList,
      chatModelList: chatModelList ?? this.chatModelList,
      keyword: keyword ?? this.keyword,
      mode: mode ?? this.mode,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [authModelList, chatModelList, keyword, mode, error, status];
}
