// ignore_for_file: must_be_immutable

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../../model/model.dart';
import '../../service/service.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key});

  CustomPopupMenuController controller = CustomPopupMenuController();

  final MessageService messageService = MessageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          VGap(height: 15.h),
          BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              if (state.senderAuthModelList.isEmpty) {
                return MessageBar(
                    name: 'Name',
                    photo: '',
                    description: 'Description',
                    onTap: () {});
              }
              return CustomPopupMenu(
                showArrow: false,
                pressType: PressType.singleClick,
                // controller: controller,
                menuBuilder: () {
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        PopUpMenuTile(
                            border: true,
                            label: 'View Profile',
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhotoViewPage(
                                        image: state
                                            .senderAuthModelList[0].photo
                                            .toString(),
                                        title: state.senderAuthModelList[0].name
                                            .toString())))),
                        PopUpMenuTile(
                          border: false,
                          label: 'Delete Chat',
                          onTap: () async {
                            await messageService.deleteDocument(
                                'chats', context.read<MessageCubit>().chatId);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: MessageBar(
                    name: state.senderAuthModelList[0].name.toString(),
                    photo: state.senderAuthModelList[0].photo.toString(),
                    description: '',
                    onTap: () {}),
              );
            },
          ),
          // VGap(height: 15.h),
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
                stream: messageService
                    .getMessage(context.read<MessageCubit>().chatId),
                builder: (context, snapshot) {
                  if (snapshot.hasData || snapshot.data != null) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];

                          return CustomPopupMenu(
                            showArrow: false,
                            pressType: PressType.longPress,
                            // controller: controller,
                            menuBuilder: () {
                              return Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    PopUpMenuTile(
                                      border: true,
                                      label: 'delete',
                                      onTap: () async {
                                        await messageService.deleteDocument(
                                            'messages', message.messageId);
                                      },
                                    ),
                                    PopUpMenuTile(
                                        border: false,
                                        label: 'details',
                                        onTap: () {}),
                                  ],
                                ),
                              );
                            },
                            child: MessageTile(
                              sender: message.senderId ==
                                  FirebaseAuth.instance.currentUser
                                      ?.uid, // Check if current user sent the message
                              text: message.content,
                              imageUrl: message.content,
                              image: message.type ==
                                  'image', // Assuming 'image' is the type for image messages
                              time:
                                  formatTimeDifference(message.time.toString()),
                              seen: message.readBy
                                  .any((id) => id != message.senderId),
                              onImageTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoViewPage(
                                            image: message.content,
                                            title: formatTimeDifference(
                                                message.time.toString()),
                                          ))),
                              onLongPress: () {},
                            ),
                          );
                        });
                  }

                  return Load(onTap: () {});
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: MessageField(
              onChanged: (x) => context.read<MessageCubit>().setContent(x),
              onSend: () => context.read<MessageCubit>().sendTextMessage(),
              onAdd: () => context.read<MessageCubit>().sendImageMessage(),
            ),
          )
        ]),
      ),
    );
  }
}
