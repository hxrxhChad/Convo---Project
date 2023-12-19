import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets.dart';

class ChatViewHeader extends StatelessWidget {
  final void Function() onTap;
  const ChatViewHeader({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Convo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
        AuthButtonSmall(label: 'Add', onTap: onTap, outlined: false)
      ]),
    );
  }
}
