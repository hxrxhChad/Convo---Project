import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'index.dart';

class ProfileHeader extends StatelessWidget {
  final String cover;
  final String dp;
  final String name;
  const ProfileHeader(
      {super.key, required this.cover, required this.dp, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 250.h, width: double.infinity),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    image: DecorationImage(
                        image: NetworkImage(cover), fit: BoxFit.cover)))),
        Positioned(
            bottom: 0,
            left: 20.w,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle),
                padding: EdgeInsets.all(5.h),
                child: Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).disabledColor,
                        image: DecorationImage(
                            image: NetworkImage(dp), fit: BoxFit.cover))))),
        Positioned(
            bottom: 17.h,
            right: 30.w,
            child: SizedBox(
              width: 180.w,
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )),
        const Positioned(
          child: SettingsBackArrow(),
        )
      ],
    );
  }
}

class SettingsBackArrow extends StatelessWidget {
  const SettingsBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.7), shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.black.withOpacity(.5),
            )),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final bool redButton;
  final String label;
  final void Function() onTap;
  const SettingsTile(
      {super.key,
      required this.icon,
      this.redButton = false,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).disabledColor.withOpacity(.1)))),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Row(
          children: [
            Icon(icon,
                color:
                    redButton ? Colors.red : Theme.of(context).iconTheme.color),
            HorizontalGap(width: 30.w),
            Text(
              label,
              style: TextStyle(
                  color: redButton
                      ? Colors.red
                      : Theme.of(context).iconTheme.color),
            )
          ],
        ),
      ),
    );
  }
}
