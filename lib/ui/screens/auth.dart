import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return Load(
            onTap: () => context.read<AuthCubit>().setStatus(Status.initial),
          );
        }
        return const AuthView();
      },
      listener: (context, state) {
        if (state.status == Status.error) {
          showSnackbar(context, state.error, Colors.red);
        }
        // navigating the screen to chat screen ---
        if (state.authId != '') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/chat', (route) => route.isFirst);
        }
      },
    );
  }
}
