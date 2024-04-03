// ignore_for_file: must_be_immutable

import 'package:chat_alpha_sept/ui/views/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/index.dart';
import '../../model/index.dart';
import '../widgets/index.dart';

class EditView extends StatelessWidget {
  EditView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            List<AuthModel> self = state.authModel
                .where((auth) => auth.authId == state.authId)
                .toList();
            return Center(
              child: Column(
                children: [
                  VGap(height: 100.h),
                  AddImage(
                    onTap: () => context.read<AuthCubit>().addImage(),
                    image: state.photo.isNotEmpty
                        ? state.photo
                        : state.authModel.isEmpty
                            ? ''
                            : self[0].photo!,
                  ),
                  VGap(height: 30.h),
                  TestField(
                      label: 'Email',
                      hintText: 'Enter your email address',
                      onChanged: (x) => context.read<AuthCubit>().setEmailId(x),
                      initialValue:
                          state.authModel.isEmpty ? '' : self[0].email!,
                      controller: emailController),
                  VGap(height: 25.h),
                  TestField(
                      label: 'Name',
                      hintText: 'Enter your name',
                      onChanged: (x) => context.read<AuthCubit>().setName(x),
                      initialValue:
                          state.authModel.isEmpty ? '' : self[0].name!,
                      controller: nameController),
                  VGap(height: 25.h),
                  TestField(
                      label: 'Username',
                      hintText: 'Enter your username',
                      onChanged: (x) =>
                          context.read<AuthCubit>().setUsername(x),
                      initialValue:
                          state.authModel.isEmpty ? '' : self[0].username!,
                      controller: usernameController),
                  VGap(height: 40.h),
                  AuthButton(
                      label: 'Update Changes',
                      onTap: () async {
                        await context.read<AuthCubit>().updateAuth();
                      },
                      outlined: false,
                      loading: state.status == Status.loading),
                  VGap(height: 20.h),
                  AuthButton(
                      label: 'Go Back',
                      onTap: () => Navigator.pop(context),
                      outlined: true,
                      loading: false)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
