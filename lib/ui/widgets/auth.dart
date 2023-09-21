import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String) onChanged;
  const AuthTextField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.obscureText,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      autocorrect: false,
      obscureText: obscureText,
      cursorColor: Theme.of(context).disabledColor,
      decoration: InputDecoration(
          hintText: hintText,
          constraints: BoxConstraints(maxWidth: 300.w),
          fillColor: Theme.of(context).secondaryHeaderColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide.none),
          filled: true),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final bool outlined;
  const AuthButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.outlined});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 300.w,
        decoration: BoxDecoration(
            color:
                outlined ? Colors.transparent : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
                color: outlined
                    ? Theme.of(context).iconTheme.color!
                    : Colors.transparent)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: outlined
                    ? Theme.of(context).iconTheme.color
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}
