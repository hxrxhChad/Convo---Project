import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/index.dart';
import '../view/index.dart';
import '../widgets/index.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          context.read<AuthCubit>().setIsLogin(false);
          context.read<AuthCubit>().setUid('');

          Navigator.pushReplacementNamed(context, '/');
        }
      },
      builder: (context, state) {
        if (state.status == Status.loading) {
          return GlobalLoadingWidget(
              onTap: () =>
                  context.read<SettingsCubit>().setStatus(Status.initial));
        }
        if (state.status == Status.error) {
          return GlobalErrorWidget(
            onPressed: () =>
                context.read<SettingsCubit>().setStatus(Status.initial),
            error: context.read<SettingsCubit>().error,
          );
        }
        return const SettingsView();
      },
    );
  }
}
