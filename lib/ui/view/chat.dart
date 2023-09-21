import 'package:flutter/material.dart';

import '../widgets/index.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthButton(
                label: 'Navigate to Profile',
                onTap: () {
                  Navigator.pushNamed(context, 'settings');
                },
                outlined: true),
          ],
        ),
      ),
    );
  }
}
