import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets.dart';

class SettingAvatar extends StatelessWidget {
  const SettingAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.h,
        width: 120.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).disabledColor));
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final bool redButton;
  final String label;
  final void Function() onTap;
  final bool border;
  const SettingTile(
      {super.key,
      required this.icon,
      this.redButton = false,
      required this.label,
      required this.onTap,
      required this.border});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: border
                        ? BorderSide(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(.04))
                        : BorderSide.none)),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 18.h),
            child: Row(children: [
              Icon(icon,
                  size: 14.h,
                  color: redButton
                      ? Colors.red
                      : Theme.of(context).iconTheme.color),
              HGap(width: 30.w),
              Text(
                label,
                style: TextStyle(
                    color: redButton
                        ? Colors.red
                        : Theme.of(context).iconTheme.color),
              )
            ])));
  }
}
