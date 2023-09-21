import 'package:chat_alpha_sept/ui/widgets/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/index.dart';
import '../view/index.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLogin == true) {
          Navigator.pushReplacementNamed(context, 'chat');
        }
      },
      builder: (context, state) {
        if (state.register == true) {
          return const RegisterView();
        }
        if (state.status == Status.loading) {
          return GlobalLoadingWidget(
              onTap: () => context.read<AuthCubit>().setStatus(Status.initial));
        }
        if (state.status == Status.error) {
          return GlobalErrorWidget(
            onPressed: () =>
                context.read<AuthCubit>().setStatus(Status.initial),
            error: context.read<AuthCubit>().error,
          );
        }
        return const AuthView();
      },
    );
  }
}
