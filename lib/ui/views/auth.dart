import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../cubit/index.dart';
import '../../utils/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VGap(height: 140.h),
            Text('Login to Eight Miles',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold)),
            VGap(height: 15.h),
            Text(
                'Enter email address and password to log in to the application',
                style: Theme.of(context).textTheme.bodySmall!.copyWith()),
            VGap(height: 50.h),
            Text(
              'Email',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5)),
            ),
            VGap(height: 10.h),
            AuthField(
                label: 'Email',
                hintText: 'example@example.com',
                onChanged: (x) {},
                initialValue: '',
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                icon: true,
                iconData: CupertinoIcons.mail,
                iconColor: Colors.red),
            VGap(height: 20.h),
            Text(
              'Password',
              style: TextStyle(
                color: Theme.of(context).iconTheme.color!.withOpacity(.5),
              ),
            ),
            VGap(height: 10.h),
            AuthField(
                label: 'Password',
                hintText: '',
                onChanged: (x) {},
                initialValue: '',
                controller: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                icon: true,
                iconData: Iconsax.key,
                iconColor: Colors.green),
            VGap(height: 20.h),
            AuthButton(
                label: 'Log in',
                onTap: () {
                  showSnackbar(
                      context,
                      'You have asked for only Google Sign in in the assignment',
                      Colors.red);
                },
                outlined: true,
                loading: false),
            VGap(height: 30.h),
            Center(
                child: Row(
              children: [
                Expanded(
                    child: Divider(
                  color: Colors.black12.withOpacity(.1),
                )),
                HGap(width: 30.w),
                Text(
                  'or',
                  style: TextStyle(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(.5)),
                ),
                HGap(width: 30.w),
                Expanded(
                    child: Divider(
                  color: Colors.black12.withOpacity(.1),
                )),
              ],
            )),
            VGap(height: 30.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status == Status.success) {
                  replace(context, const HomeView());
                }
              },
              builder: (context, state) {
                return AuthButton(
                  label: 'Sign in with Google',
                  onTap: () => context.read<AuthCubit>().LOGIN(),
                  outlined: false,
                  loading: state.status == Status.loading,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
