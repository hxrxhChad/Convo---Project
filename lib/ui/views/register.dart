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
            VGap(height: 140.h),
            Text("Let's get Started",
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold)),
            VGap(height: 10.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return PaddedBox(
                    label:
                        'Set a ${context.read<RegisterCubit>().key == 0 ? 'Username' : context.read<RegisterCubit>().key == 1 ? 'Email' : context.read<RegisterCubit>().key == 2 ? 'Password' : 'Name'} ');
              },
            ),
            VGap(height: 40.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return Text(
                  context.read<RegisterCubit>().key == 0
                      ? 'Username'
                      : context.read<RegisterCubit>().key == 1
                          ? 'Email'
                          : context.read<RegisterCubit>().key == 2
                              ? 'Password'
                              : 'Name',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                      fontWeight: FontWeight.bold),
                );
              },
            ),
            VGap(height: 10.h),
            AuthField(
                hintText: 'Enter a unique username',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (x) {},
                initialValue: '',
                eye: false),
            VGap(height: 20.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AuthButtonSmall(
                      label: 'Back',
                      onTap: () {
                        if (context.read<RegisterCubit>().key > 0) {
                          context
                              .read<RegisterCubit>()
                              .setKey(context.read<RegisterCubit>().key - 1);
                          print(context.read<RegisterCubit>().key);
                        }
                      },
                      outlined: true,
                    ),
                    AuthButtonSmall(
                      label: context.read<RegisterCubit>().key == 3
                          ? 'Submit'
                          : 'Next',
                      onTap: () {
                        if (context.read<RegisterCubit>().key < 3) {
                          context
                              .read<RegisterCubit>()
                              .setKey(context.read<RegisterCubit>().key + 1);
                          print(context.read<RegisterCubit>().key);
                          if (context.read<RegisterCubit>().key == 3) {}
                        }
                      },
                      outlined: false,
                    )
                  ],
                );
              },
            ),
            VGap(height: 30.h),
            Center(
                child: Text(
              '⎯⎯⎯⎯⎯⎯⎯⎯⎯     OR    ⎯⎯⎯⎯⎯⎯⎯⎯⎯',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5)),
            )),
            VGap(height: 30.h),
            AuthButton(label: 'Back to Login', onTap: () {}, outlined: true),
          ],
        ),
      ),
    );
  }
}
