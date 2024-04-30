// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/cubit.dart';
import '../../service/service.dart';
import '../widgets/widgets.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Column(children: [
            VGap(height: 70.h),
            SettingAvatar(
              image:
                  state.authModel.isNotEmpty ? state.authModel[0].photo! : '',
              onTap: () {},
            ),
            VGap(height: 15.h),
            Text(state.authModel.isEmpty ? '' : state.authModel[0].name!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
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
                      onTap: () => showModalBottomSheet(
                          useSafeArea: true,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SizedBox(
                                height: 450.h,
                                child: const Scaffold(
                                  body: EditProfile(),
                                ),
                              )),
                      border: true),
                  SettingTile(
                      icon: Iconsax.shield,
                      label: 'Privacy Policy',
                      onTap: state.settingModel.isEmpty
                          ? () {}
                          : () async {
                              if (await canLaunch(
                                  state.settingModel[0].privacyPolicy!)) {
                                // Launch the URL
                                await launch(
                                    state.settingModel[0].privacyPolicy!);
                              }
                            },
                      border: true),
                  SettingTile(
                      icon: Iconsax.note,
                      label: 'Terms of Service',
                      onTap: state.settingModel.isEmpty
                          ? () {}
                          : () async {
                              if (await canLaunch(
                                  state.settingModel[0].termsOfService!)) {
                                // Launch the URL
                                await launch(
                                    state.settingModel[0].termsOfService!);
                              }
                            },
                      border: true),
                  SettingTile(
                      icon: Iconsax.people,
                      label: 'Community Guidelines',
                      onTap: state.settingModel.isEmpty
                          ? () {}
                          : () async {
                              if (await canLaunch(
                                  state.settingModel[0].communityGuidelines!)) {
                                // Launch the URL
                                await launch(
                                    state.settingModel[0].communityGuidelines!);
                              }
                            },
                      border: true),
                  SettingTile(
                      icon: Iconsax.support,
                      label: 'Support',
                      onTap: state.settingModel.isEmpty
                          ? () {}
                          : () async {
                              if (await canLaunch(
                                  state.settingModel[0].support!)) {
                                // Launch the URL
                                await launch(state.settingModel[0].support!);
                              }
                            },
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
                              await authService.logout().whenComplete(() {
                                context.read<AuthCubit>().setAuthId('');
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => route.isFirst);
                            },
                            () => Navigator.pop(context),
                          ),
                      border: false)
                ]),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(),
                const Text(
                  'Update Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                VGap(height: 40.h),
                Row(
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
                            onChanged: (x) =>
                                context.read<SettingCubit>().setUsername(x),
                            initialValue: state.authModel.isEmpty
                                ? ''
                                : state.authModel[0].username!,
                            eye: false,
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                    const HGap(width: 20),
                    BlocBuilder<SettingCubit, SettingState>(
                      builder: (context, state) {
                        return RegisterAddImage(
                          onTap: () {
                            context
                                .read<SettingCubit>()
                                .addImage()
                                .whenComplete(() => Navigator.pop(context));
                          },
                          image: state.photo.isNotEmpty
                              ? state.photo
                              : state.authModel.isEmpty
                                  ? ''
                                  : state.authModel[0].photo!,
                        );
                      },
                    )
                  ],
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
                  onChanged: (x) => context.read<SettingCubit>().setName(x),
                  initialValue:
                      state.authModel.isEmpty ? '' : state.authModel[0].name!,
                  eye: false,
                  onTap: () {},
                ),
                VGap(height: 60.h),
                AuthButton(
                    label: 'Update Changes',
                    onTap: () => TwoOpDialog(
                        context,
                        'Uppdate Changes',
                        'Confirm to update the changes',
                        'Confirm',
                        'Cancel',
                        () => context.read<SettingCubit>().updateSetting(),
                        () => Navigator.pop(context)),
                    outlined: false),
                VGap(height: 10.h),
                AuthButton(
                    label: 'Delete Account Permanently',
                    onTap: () => TwoOpDialog(
                        context,
                        'Delete Account',
                        'Are you sure, you want to delete this account. The process is irreversible.',
                        'Yes, Delete',
                        'Go Back',
                        () {},
                        () => Navigator.pop(context)),
                    outlined: true),
              ],
            ),
          ),
        );
      },
    );
  }
}
