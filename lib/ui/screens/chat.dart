import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          showSnackbar(context, state.error, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.status == Status.loading) {
          return Load(
            onTap: () =>
                context.read<RegisterCubit>().setStatus(Status.initial),
          );
        }
        if (state.mode == 'search') {
          return SearchView();
        }
        return ChatView();
      },
    );
  }
}
