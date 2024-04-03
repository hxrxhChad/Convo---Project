// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../cubit/index.dart';
import '../../model/index.dart';
import '../../utils/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          List<AuthModel> self = state.authModel
              .where((auth) => auth.authId == state.authId)
              .toList();
          return Column(children: [
            VGap(height: 70.h),
            SettingAvatar(
              image: state.authModel.isNotEmpty ? self[0].photo! : '',
              onTap: () => push(
                  context,
                  PhotoViewPage(
                    image: state.authModel.isEmpty ? '' : self[0].photo!,
                    title: 'Profile Picture',
                  )),
            ),
            VGap(height: 15.h),
            Text('Name : ${state.authModel.isEmpty ? '' : self[0].name!}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            VGap(height: 10.h),
            Text('Email : ${state.authModel.isEmpty ? '' : self[0].email!}'),
            VGap(height: 10.h),
            Text(
              'username : ${state.authModel.isEmpty ? '' : self[0].username!}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
            VGap(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.withOpacity(.03)),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue.withOpacity(.03)),
                child: Column(children: [
                  SettingTile(
                      icon: Iconsax.edit,
                      label: 'Edit Profile',
                      onTap: () => push(context, EditView()),
                      border: true),
                  SettingTile(
                      icon: Iconsax.export,
                      redButton: true,
                      label: 'Log out of this account',
                      onTap: () => TwoOpDialog(
                            context,
                            'Sign Out',
                            'Are you sure you want to sign out',
                            'Sign out',
                            'Go Back',
                            () async {
                              await context.read<AuthCubit>().SIGNOUT();
                              replace(context, const AuthView());
                            },
                            () => Navigator.pop(context),
                          ),
                      border: false)
                ]),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
