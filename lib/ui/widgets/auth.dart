// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthField extends StatelessWidget {
  double? maxWidth;
  final String label;
  final String hintText;
  final void Function(String) onChanged;
  final String initialValue;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final IconData iconData;
  final bool icon;
  final Color iconColor;
  AuthField({
    super.key,
    this.maxWidth,
    required this.label,
    required this.hintText,
    required this.onChanged,
    required this.initialValue,
    required this.controller,
    required this.keyboardType,
    required this.icon,
    required this.iconData,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          onChanged: onChanged,
          cursorHeight: 15.h,
          textAlignVertical: TextAlignVertical.center,
          autocorrect: false,
          keyboardType: keyboardType,
          cursorColor: Theme.of(context).disabledColor,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: icon
                ? Icon(
                    iconData,
                    size: 15.h,
                    color: iconColor,
                  )
                : const SizedBox.shrink(),
            hintStyle: TextStyle(
                color: Theme.of(context).iconTheme.color!.withOpacity(.5)),
            contentPadding:
                EdgeInsets.only(left: 20.w, top: 9.h, right: 20.w, bottom: 9.h),
            constraints: BoxConstraints(
                maxHeight: 40.h, maxWidth: maxWidth != null ? maxWidth! : 300),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.2)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.2)),
            ),
          ),
        ),
      ],
    );
  }
}

class CountryCodeBox extends StatelessWidget {
  final String countryCode;
  final void Function() onTap;
  const CountryCodeBox({
    super.key,
    required this.countryCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: Theme.of(context).iconTheme.color!.withOpacity(.2)),
        ),
        child: Center(
          child: Text(
            countryCode,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 4),
          ),
        ),
      ),
    );
  }
}

class PaddedBox extends StatelessWidget {
  final String text;
  const PaddedBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.1),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final bool outlined;
  final bool loading;
  const AuthButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.outlined,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 300.w,
        decoration: BoxDecoration(
            color:
                outlined ? Colors.transparent : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: outlined
                    ? Theme.of(context).iconTheme.color!.withOpacity(.1)
                    : Colors.transparent)),
        child: Center(
          child: loading
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.5,
                  ),
                )
              : Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: outlined ? Colors.black : Colors.white)),
        ),
      ),
    );
  }
}
