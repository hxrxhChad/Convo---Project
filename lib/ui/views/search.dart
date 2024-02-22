// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../../model/model.dart';
import '../../service/service.dart';
import '../widgets/widgets.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final ChatService chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            VGap(height: 15.h),
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return SearchViewHeader(
                  onChanged: (x) {
                    debugPrint(state.keyword);
                    context.read<ChatCubit>().setKeyword(x);
                  },
                  onTap: () => context.read<ChatCubit>().setMode('chat'),
                );
              },
            ),
            VGap(height: 15.h),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  List<AuthModel> filteredList = [];

                  if (state.keyword.isNotEmpty) {
                    filteredList = state.authModelList
                        .where((authModel) =>
                            authModel.name!
                                .toLowerCase()
                                .startsWith(state.keyword.toLowerCase()) &&
                            authModel.authId !=
                                FirebaseAuth.instance.currentUser!.uid)
                        .toList();
                  }

                  return ListView.builder(
                      itemCount: filteredList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchTile(
                          onTap: () async {
                            debugPrint(
                                'searched id => ${filteredList[index].authId!} auth Id -> ${context.read<AuthCubit>().authId}');
                            String? chatId = await chatService.getChatId(
                                filteredList[index].authId!,
                                context.read<AuthCubit>().authId);
                            if (chatId != '') {
                              debugPrint(chatId);
                              context.read<MessageCubit>().setChatId(chatId!);
                              context.read<MessageCubit>().streamSenderAuth();
                              Navigator.pushNamed(context, '/message');
                            }
                          },
                          imageUrl: filteredList[index].photo.toString(),
                          name: filteredList[index].name.toString(),
                          description: 'Tap to send a message ...',
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
