import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../views/views.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MessageView();
      },
    );
  }
}
