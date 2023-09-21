import 'package:flutter_bloc/flutter_bloc.dart';

enum ChatState { initial, loading, error, loaded }

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.initial);

  Future<void> signOut() async {}

  void refresh() {
    emit(ChatState.initial);
  }
}
