import 'dart:convert';
import 'package:equatable/equatable.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel extends Equatable {
  final String messageId;
  final String chatId;
  final String senderId;
  final int time;
  final String type;
  final String content;
  final List<String> readBy;

  const MessageModel({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.time,
    required this.type,
    required this.content,
    required this.readBy,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json["messageId"],
        chatId: json["chatId"],
        senderId: json["senderId"],
        time: json["time"],
        type: json["type"],
        content: json["content"],
        readBy: List<String>.from(json["readBy"]),
      );

  Map<String, dynamic> toJson() => {
        'messageId': messageId,
        'chatId': chatId,
        'senderId': senderId,
        'time': time,
        'type': type,
        'content': content,
        'readBy': readBy,
      };

  @override
  List<Object?> get props =>
      [messageId, chatId, senderId, time, type, content, readBy];
}
