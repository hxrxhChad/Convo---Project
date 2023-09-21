import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/index.dart';
import '../widgets/index.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Convo.',
              style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              'by Leaf',
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
            VerticalGap(height: 50.h),
            AuthTextField(
                hintText: 'Enter email',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (v) => context.read<AuthCubit>().setEmail(v)),
            VerticalGap(height: 20.h),
            AuthTextField(
                hintText: 'Enter password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (v) => context.read<AuthCubit>().setPassword(v)),
            VerticalGap(height: 20.h),
            AuthButton(
              label: 'Submit',
              onTap: () => context.read<AuthCubit>().login(),
              outlined: false,
            ),
            VerticalGap(height: 20.h),
            AuthButton(
              label: 'Register',
              onTap: () => context.read<AuthCubit>().setRegister(true),
              outlined: true,
            ),
          ],
        ),
      ),
    );
  }
}
