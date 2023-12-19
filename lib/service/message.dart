import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/model.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessage(String chatId) {
    return _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('time')
        .snapshots()
        .map((event) => event.docs
            .map((e) => MessageModel(
                messageId: e['messageId'],
                chatId: e['chatId'],
                senderId: e['senderId'],
                time: e['time'],
                type: e['type'],
                content: e['content']))
            .toList());
  }
}
