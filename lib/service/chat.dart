import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model.dart';

class ChatService {
  Stream<List<AuthModel>> getAuthModel() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // Convert each document snapshot to AuthModel instance
              return AuthModel.fromJson(doc.data());
            }).toList());
  }

  Stream<List<ChatModel>> getChatModel() {
    return FirebaseFirestore.instance
        .collection('chats')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // Convert each document snapshot to ChatModel instance
              return ChatModel.fromJson(doc.data());
            }).toList());
  }

  Future<String?> getChatId(String userId, String otherUserId) async {
    // Query Firestore to check if the condition is met

    QuerySnapshot firstValueQuerySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: userId)
        .get();

    // Filter out documents that contain the second value
    for (QueryDocumentSnapshot doc in firstValueQuerySnapshot.docs) {
      if (doc['participants'].contains(otherUserId)) {
        // Found a document that contains both values
        return doc.id;
      }
    }
    // Create a new chat document in Firestore
    DocumentReference chatRef =
        FirebaseFirestore.instance.collection('chats').doc();

    // Define the chat data
    Map<String, dynamic> chatData = {
      'chatId': chatRef.id,
      'participants': [userId, otherUserId],
      // Add other fields as needed
    };

    // Set the chat document with the defined data
    await chatRef.set(chatData);

    // Return the newly created chatId
    return chatRef.id;
  }

  Future<String?> getRecentMessage(String chatId) async {
    try {
      // Query the "messages" collection for messages with the specified chat ID
      final querySnapshot = await FirebaseFirestore.instance
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .orderBy('time',
              descending: true) // Order messages by time in descending order
          .limit(1) // Limit the result to 1 message (the latest)
          .get();

      // Check if any message was found
      if (querySnapshot.docs.isNotEmpty) {
        // Extract the content of the latest message
        final latestMessageId = querySnapshot.docs.first['messageId'];
        return latestMessageId;
      } else {
        // No message found for the specified chat ID
        return null;
      }
    } catch (error) {
      // Handle any errors that occur during the process
      debugPrint('Error fetching recent message: $error');
      return null;
    }
  }
}
