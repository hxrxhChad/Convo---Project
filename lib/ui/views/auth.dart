import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../widgets/widgets.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

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
            Text('Login to Convo',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
            VGap(height: 15.h),
            const PaddedBox(label: 'Email Verification'),
            VGap(height: 50.h),
            Text(
              'Email',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
              hintText: 'user@example.com',
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              onChanged: (x) => context.read<AuthCubit>().setEmail(x),
              initialValue: context.read<AuthCubit>().email,
              eye: false,
              onTap: () {},
            ),
            VGap(height: 20.h),
            Text(
              'Password',
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
              hintText: '!^&*#',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (x) => context.read<AuthCubit>().setPassword(x),
              initialValue: context.read<AuthCubit>().password,
              eye: true,
              onTap: () {},
            ),
            VGap(height: 20.h),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return AuthButton(
                    label: 'Sign in',
                    onTap: () {
                      context.read<AuthCubit>().LOGIN();
                    },
                    outlined: false);
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
            AuthButton(
                label: 'Register',
                onTap: () => Navigator.pushNamed(context, '/register'),
                outlined: true),
          ],
        ),
      ),
    );
  }
}
