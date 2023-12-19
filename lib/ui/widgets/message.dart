import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MessageField extends StatelessWidget {
  final void Function(String) onChanged;
  const MessageField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
      onChanged: onChanged,
      cursorHeight: 15.h,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: false,
      cursorColor: Theme.of(context).disabledColor,
      decoration: InputDecoration(
        hintText: 'Enter your message ...',
        hintStyle: TextStyle(color: Theme.of(context).iconTheme.color!.withOpacity(.3),),
          suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.send_1,
                  size: 18.h,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                ),
              )),
          fillColor: Theme.of(context).iconTheme.color!.withOpacity(.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide:
                  BorderSide.none),
          filled: true),
    );
  }
}
