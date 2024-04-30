// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class MessageService {
  Stream<List<MessageModel>> getMessage(String chatId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('time', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        // Retrieve readBy field from the document snapshot
        List<String> readBy = List<String>.from(doc['readBy'] ?? []);

        return MessageModel(
          messageId: doc['messageId'],
          chatId: doc['chatId'],
          senderId: doc['senderId'],
          time: doc['time'],
          type: doc['type'],
          content: doc['content'],
          readBy: readBy,
        );
      }).toList();
    });
  }

  Future<void> sendImageMessage(String chatId, String content) async {
    // Create a new chat document in Firestore
    DocumentReference messageRef =
        FirebaseFirestore.instance.collection('messages').doc();

    // Define the chat data
    Map<String, dynamic> messageData = {
      'messageId': messageRef.id, // Generate a unique message ID if needed
      'chatId': chatId, // The ID of the chat
      'senderId':
          FirebaseAuth.instance.currentUser?.uid, // The ID of the sender
      'time': DateTime.now().millisecondsSinceEpoch, // Current timestamp
      'type': 'image', // Type of the message (e.g., 'text', 'image')
      'content': content, // The text content of the message
      'readBy': [], // Initialize the readBy field with an empty list
    };

    // Set the chat document with the defined data
    await messageRef.set(messageData);
  }

  Future<void> sendTextMessage(String chatId, String content) async {
    // Create a new chat document in Firestore
    DocumentReference messageRef =
        FirebaseFirestore.instance.collection('messages').doc();

    // Define the chat data
    Map<String, dynamic> messageData = {
      'messageId': messageRef.id, // Generate a unique message ID if needed
      'chatId': chatId, // The ID of the chat
      'senderId':
          FirebaseAuth.instance.currentUser?.uid, // The ID of the sender
      'time': DateTime.now().millisecondsSinceEpoch, // Current timestamp
      'type': 'text', // Type of the message (e.g., 'text', 'image')
      'content': content, // The text content of the message
      'readBy': [], // Initialize the readBy field with an empty list
    };

    // Set the chat document with the defined data
    await messageRef.set(messageData);
  }

  Stream<List<AuthModel>> getSenderAuth(String chatId) async* {
    // Get the document snapshot for the given chat ID
    final chatSnapshot =
        await FirebaseFirestore.instance.collection('chats').doc(chatId).get();

    // Extract the participants list from the chat document
    final List<String> participants =
        List<String>.from(chatSnapshot['participants']);

    // Remove the current user's ID from the participants list
    participants.removeWhere((participantId) =>
        participantId == FirebaseAuth.instance.currentUser!.uid);

    // Reference to the Firestore collection containing user data
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');

    // Query user data from Firestore using remaining participant IDs
    final querySnapshot =
        await usersRef.where('authId', whereIn: participants).get();

    // Map each document snapshot to an AuthModel object
    final List<AuthModel> senderAuthList = querySnapshot.docs
        .map((doc) => AuthModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    debugPrint(senderAuthList.length.toString());

    // Yield the senderAuthList as a stream
    yield senderAuthList;
  }

  Future<void> deleteDocument(String collectionName, String documentId) async {
    try {
      // Get a reference to the document
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);

      // Delete the document
      await docRef.delete();
      print('Document deleted successfully!');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
