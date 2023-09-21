import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../cubits/index.dart';
import '../widgets/index.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                const ProfileHeader(
                    cover:
                        'https://images.unsplash.com/photo-1579412690850-bd41cd0af397?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80',
                    dp: 'https://plus.unsplash.com/premium_photo-1666298860111-2c40530315da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
                    name: 'Brogrammer'),
                VerticalGap(height: 10.h),
                SettingsTile(
                    icon: Iconsax.edit, label: 'Edit Profile', onTap: () {}),
                SettingsTile(
                    icon: Iconsax.security_card,
                    label: 'Privacy & Security',
                    onTap: () {}),
                SettingsTile(
                    icon: context.watch<MainCubit>().theme == ThemeState.dark
                        ? Iconsax.sun_1
                        : Iconsax.moon,
                    label: 'Change Theme',
                    onTap: () => context.read<MainCubit>().setTheme(
                        context.read<MainCubit>().theme == ThemeState.light
                            ? ThemeState.dark
                            : ThemeState.light)),
                SettingsTile(
                    icon: Iconsax.export,
                    redButton: true,
                    label: 'Log out of this account',
                    onTap: () => showConfirmDialog(context, 'Sign Out',
                            'Do you really want to log out from ${context.read<AuthCubit>().email}',
                            () {
                          Navigator.pop(context);
                          context.read<SettingsCubit>().signOut();
                        })),
                VerticalGap(height: 100.h),
                const Text(
                  'Leaf v1.0.0',
                  style: TextStyle(fontWeight: FontWeight.w700),
                )
              ],
            ),
          )),
    );
  }
}
