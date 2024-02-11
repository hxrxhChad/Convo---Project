import '../model/model.dart';
import 'service.dart';

class ChatService {
  final MessageService _messageService = MessageService();

  Stream<List<MessageModel>> messageList() {
    return _messageService.getMessage('chatId');
  }

  // Stream<List<ChatModel>> getChatModel(){}
}
