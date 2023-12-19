import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../widgets/widgets.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        VGap(height: 70.h),
        const SettingAvatar(),
        VGap(height: 15.h),
        Text('Brogrammer',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp)),
        VGap(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12.withOpacity(.03)),
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor.withOpacity(.03)),
            child: Column(children: [
              SettingTile(
                  icon: Iconsax.edit,
                  label: 'Edit Profile',
                  onTap: () {},
                  border: true),
              SettingTile(
                  icon: Iconsax.moon,
                  label: 'Change Theme',
                  onTap: () {},
                  border: true),
              SettingTile(
                  icon: Iconsax.export,
                  redButton: true,
                  label: 'Log out of this account',
                  onTap: () {},
                  border: false)
            ]),
          ),
        ),
      ]),
    );
  }
}
