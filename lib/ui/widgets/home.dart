import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../views/index.dart';

class SettingAvatar extends StatelessWidget {
  final String image;
  final void Function() onTap;
  const SettingAvatar({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: SizedBox(
          height: 100.h,
          width: 100.h,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(15),
              child: Load(onTap: () {}),
            ),
            errorWidget: (context, url, error) => const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                Iconsax.information,
                color: Colors.blue,
                size: 14,
              ),
            ),
          ),
        ),
      ),
    );
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
              Icon(
                icon,
                size: 14.h,
                color:
                    redButton ? Colors.red : Theme.of(context).iconTheme.color,
              ),
              HGap(width: 30.w),
              Text(
                label,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: redButton
                        ? Colors.red
                        : Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.w500),
              )
            ])));
  }
}
