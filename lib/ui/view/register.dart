import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/index.dart';
import '../widgets/index.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              VerticalGap(height: 100.h),
              Text(
                'Register.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.sp),
              ),
              VerticalGap(height: 50.h),
              AuthTextField(
                  hintText: 'Enter a username',
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (v) => context.read<AuthCubit>().setUsername(v)),
              VerticalGap(height: 20.h),
              AuthTextField(
                  hintText: 'Enter email',
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  onChanged: (v) => context.read<AuthCubit>().setEmail(v)),
              VerticalGap(height: 20.h),
              AuthTextField(
                  hintText: 'Enter password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  onChanged: (v) => context.read<AuthCubit>().setPassword(v)),
              VerticalGap(height: 20.h),
              AuthTextField(
                  hintText: 'Confirm password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  onChanged: (v) => context.read<AuthCubit>().setRePassword(v)),
              VerticalGap(height: 20.h),
              AuthButton(
                label: 'Submit',
                onTap: () => context.read<AuthCubit>().REGISTER(),
                outlined: false,
              ),
              VerticalGap(height: 20.h),
              AuthButton(
                label: 'Sign in',
                onTap: () => context.read<AuthCubit>().setRegister(false),
                outlined: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
