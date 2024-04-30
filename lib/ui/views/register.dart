// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../widgets/widgets.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VGap(height: 120.h),
            Text("Let's get Started",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
            VGap(height: 15.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return PaddedBox(
                    label:
                        'Set a ${state.key == 0 ? 'Username' : state.key == 1 ? 'Email' : state.key == 2 ? 'Password' : 'Name'} ');
              },
            ),
            VGap(height: 40.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(.5),
                                fontWeight: FontWeight.bold),
                          ),
                          VGap(height: 10.h),
                          AuthField(
                            hintText: 'god, etc',
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            onChanged: (x) {
                              context.read<RegisterCubit>().setUsername(x);
                              if (state.taken) {
                                context
                                    .read<RegisterCubit>()
                                    .setError('Username already in use');
                                context
                                    .read<RegisterCubit>()
                                    .setStatus(Status.error);
                              } else {
                                context
                                    .read<RegisterCubit>()
                                    .setStatus(Status.initial);
                              }
                            },
                            initialValue:
                                context.read<RegisterCubit>().username,
                            eye: false,
                            onTap: () =>
                                context.read<RegisterCubit>().setKey(0),
                          )
                        ],
                      ),
                    ),
                    const HGap(width: 20),
                    RegisterAddImage(
                      onTap: () => context.read<RegisterCubit>().addImage(),
                      image: state.photo,
                    )
                  ],
                );
              },
            ),
            VGap(height: 10.h),
            Text(
              'Email',
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
              hintText: 'user@example.com',
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              onChanged: (x) => context.read<RegisterCubit>().setEmail(x),
              initialValue: context.read<RegisterCubit>().email,
              eye: false,
              onTap: () => context.read<RegisterCubit>().setKey(1),
            ),
            VGap(height: 10.h),
            Text(
              'Password',
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
              hintText: '%#!#as%',
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
              onChanged: (x) {
                context.read<RegisterCubit>().setPassword(x);
                if (x.length < 8) {
                  context
                      .read<RegisterCubit>()
                      .setError('Password must be at least 8 characters');
                  context.read<RegisterCubit>().setStatus(Status.error);
                } else {
                  context.read<RegisterCubit>().setStatus(Status.initial);
                }
              },
              initialValue: context.read<RegisterCubit>().password,
              eye: false,
              onTap: () => context.read<RegisterCubit>().setKey(2),
            ),
            VGap(height: 10.h),
            Text(
              'Name',
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
              hintText: 'John Smith',
              keyboardType: TextInputType.name,
              obscureText: false,
              onChanged: (x) => context.read<RegisterCubit>().setName(x),
              initialValue: context.read<RegisterCubit>().name,
              eye: false,
              onTap: () => context.read<RegisterCubit>().setKey(3),
            ),
            VGap(height: 60.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthButtonSmall(
                  label: 'Back',
                  onTap: () => Navigator.pop(context),
                  outlined: true,
                ),
                AuthButtonSmall(
                  label: 'Submit',
                  onTap: () => context.read<RegisterCubit>().REGISTER(),
                  outlined: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
