import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalErrorWidget extends StatelessWidget {
  final String error;
  final void Function() onPressed;
  const GlobalErrorWidget(
      {super.key, required this.onPressed, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Something wrong !',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.sp),
            ),
            VerticalGap(height: 5.h),
            Text(error),
            VerticalGap(height: 40.h),
            ElevatedButton(
                onPressed: onPressed,
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}

class GlobalLoadingWidget extends StatefulWidget {
  final void Function() onTap;
  const GlobalLoadingWidget({super.key, required this.onTap});

  @override
  State<GlobalLoadingWidget> createState() => _GlobalLoadingWidgetState();
}

class _GlobalLoadingWidgetState extends State<GlobalLoadingWidget> {
  late Timer _timer; // Declare a timer variable

  @override
  void initState() {
    super.initState();
    // Start a timer to show the button after 1 minute
    _timer = Timer(const Duration(minutes: 1), () {
      setState(() {
        tookSoLong = true;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool tookSoLong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tookSoLong
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something wrong !',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 17.sp),
                  ),
                  VerticalGap(height: 5.h),
                  const Text('Operation took so long'),
                  VerticalGap(height: 40.h),
                  ElevatedButton(
                      onPressed: widget.onTap,
                      child: const Text(
                        'Go Back',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            : CircularProgressIndicator(
                strokeWidth: 4,
                color: Theme.of(context).disabledColor,
              ),
      ),
    );
  }
}

class VerticalGap extends StatelessWidget {
  final double height;
  const VerticalGap({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HorizontalGap extends StatelessWidget {
  final double width;
  const HorizontalGap({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

void showToast(String msg) {}

void showConfirmDialog(BuildContext context, String title, String description,
    void Function() onTap) {
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Theme.of(context).shadowColor.withOpacity(0.5),
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          shadowColor: Theme.of(context).shadowColor.withOpacity(0.1),
          contentPadding: EdgeInsets.zero,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                height: 250.h,
                width: 300.h,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.85),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Text(
                              title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          VerticalGap(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child:
                                Text(description, textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).disabledColor.withOpacity(.1),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 10.h),
                        child: const Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).disabledColor.withOpacity(.1),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          top: 10.w,
                          bottom: 20.w,
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
