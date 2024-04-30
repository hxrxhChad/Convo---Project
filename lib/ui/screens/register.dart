import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
      if (state.status == Status.loading) {
        return Load(
          onTap: () => context.read<RegisterCubit>().setStatus(Status.initial),
        );
      }
      return const RegisterView();
    }, listener: (context, state) {
      if (state.status == Status.error) {
        showSnackbar(context, state.error, Colors.red);
      }
      if (state.status == Status.success) {
        context
            .read<AuthCubit>()
            .setAuthId(FirebaseAuth.instance.currentUser!.uid);
        Navigator.pushNamedAndRemoveUntil(
            context, '/chat', (route) => route.isFirst);
      }
    });
  }
}
