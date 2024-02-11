import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold)),
            VGap(height: 10.h),
            const PaddedBox(label: 'Email Verification'),
            VGap(height: 40.h),
            Text(
              'Email Address',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
                hintText: 'Enter your email address',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (x) {},
                initialValue: '',
                eye: false),
            VGap(height: 15.h),
            Text(
              'Password',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  fontWeight: FontWeight.bold),
            ),
            VGap(height: 10.h),
            AuthField(
                hintText: 'Enter your password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (x) {},
                initialValue: '',
                eye: true),
            VGap(height: 20.h),
            AuthButton(label: 'Sign in', onTap: () {}, outlined: false),
            VGap(height: 30.h),
            Center(
                child: Text(
              '⎯⎯⎯⎯⎯⎯⎯⎯⎯     OR    ⎯⎯⎯⎯⎯⎯⎯⎯⎯',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5)),
            )),
            VGap(height: 30.h),
            AuthButton(label: 'Register', onTap: () {}, outlined: true),
          ],
        ),
      ),
    );
  }
}
