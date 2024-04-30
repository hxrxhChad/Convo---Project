// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel extends Equatable {
  String? chatId;
  List<String>? participants;

  ChatModel({
    this.chatId,
    this.participants,
  });

  ChatModel copyWith({
    String? chatId,
    List<String>? participants,
  }) =>
      ChatModel(
        chatId: chatId ?? this.chatId,
        participants: participants ?? this.participants,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatId: json["chatId"],
        participants: json["participants"] == null
            ? []
            : List<String>.from(json["participants"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "participants": participants == null
            ? []
            : List<dynamic>.from(participants!.map((x) => x)),
      };

  @override
  List<Object?> get props => [chatId, participants];
}
