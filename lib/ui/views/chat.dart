import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../../model/model.dart';
import '../../service/service.dart';
import '../widgets/widgets.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final ChatService chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          VGap(height: 15.h),
          ChatViewHeader(
            onTap: () => Navigator.pushNamed(context, '/setting'),
            onTapAdd: () => context.read<ChatCubit>().setMode('search'),
          ),
          VGap(height: 15.h),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                // Filter the chat list based on the current user's ID
                List<ChatModel> filteredChatList =
                    state.chatModelList.where((chat) {
                  // Check if the participants array contains the current user's ID
                  return chat.participants!
                      .contains(context.read<AuthCubit>().authId);
                }).toList();
                // if participants array in "chats" collection contains FirebaseAuth.instance.currentUser.uid

                return ListView.builder(
                    itemCount: filteredChatList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final chat = filteredChatList[index];
                      // find the other participant id other than the current user id from chat.participants array
                      final otherParticipantId = chat.participants?.firstWhere(
                        (participantId) =>
                            participantId !=
                            FirebaseAuth.instance.currentUser!.uid,
                        orElse: () => '',
                      );

                      // find the latest messageId with reference to the chatId present in the "messages" collection
                      // final recentMessageId =
                      //     chatService.getRecentMessage(chat.chatId!);

                      return ChatTile(
                        onTap: () {
                          if (chat.chatId != '') {
                            debugPrint(chat.chatId);
                            context
                                .read<MessageCubit>()
                                .setChatId(chat.chatId!);
                            context.read<MessageCubit>().streamSenderAuth();

                            Navigator.pushNamed(context, '/message');
                          }
                        },
                        otherParticipantId: otherParticipantId!,
                        chatId: chat.chatId!,
                      );
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
