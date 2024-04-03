// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class VGap extends StatelessWidget {
  final double height;
  const VGap({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HGap extends StatelessWidget {
  final double width;
  const HGap({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class Load extends StatefulWidget {
  final void Function() onTap;
  const Load({super.key, required this.onTap});

  @override
  State<Load> createState() => _LoadState();
}

class _LoadState extends State<Load> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to stop loading after 30 seconds
    _timer = Timer(const Duration(seconds: 5), () {
      // Stop loading after 30 seconds
      // Navigator.pop(context);
      widget.onTap;
    });

    // widget.onTap;
  }

  @override
  void dispose() {
    // Dispose the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

// if loader is loading till 30 seconds then stop loading and listen to onTap function

void showSnackbar(BuildContext context, String content, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(fontSize: 11),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 1),
    ),
  );
}

class PhotoViewPage extends StatelessWidget {
  final String image;
  final String title;
  PhotoViewPage({super.key, required this.image, required this.title});

  final _flutterMediaDownloaderPlugin = MediaDownload();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.back,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.cloud_download,
                  size: 20,
                ),
                onPressed: () async {
                  _flutterMediaDownloaderPlugin
                      .downloadMedia(context, image)
                      .whenComplete(() => showSnackbar(context,
                          'Image downloaded successfully', Colors.green));
                },
              ),
            ),
          ],
        ),
        body: PhotoView(
          imageProvider: CachedNetworkImageProvider(image),
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 2,
          enableRotation: false,
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          loadingBuilder: (context, event) => Center(
            child: Load(
              onTap: () {},
            ),
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
TwoOpDialog(
    BuildContext context,
    String title,
    String description,
    String fText,
    String sText,
    void Function() fPress,
    void Function() sPress) {
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0.1),
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.1),
          contentPadding: const EdgeInsets.all(0),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                height: 200.h,
                width: 150.w,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(01),
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.05),
                    ),
                    InkWell(
                      onTap: fPress,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Center(
                          child: Text(
                            fText,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.05),
                    ),
                    InkWell(
                      onTap: sPress,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 10.h, bottom: 20.h),
                        child: Center(
                          child: Text(
                            sText,
                            style: TextStyle(fontSize: 11.sp),
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
