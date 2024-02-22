import 'package:chat_alpha_sept/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../views/views.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == Status.loading) {
          return Load(
              onTap: () =>
                  context.read<SettingCubit>().setStatus(Status.initial));
        }
        return SettingView();
      },
    );
  }
}
