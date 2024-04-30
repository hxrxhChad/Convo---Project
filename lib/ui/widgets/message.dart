import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets.dart';

class MessageField extends StatelessWidget {
  final void Function(String) onChanged;
  final void Function() onSend;
  final void Function() onAdd;

  const MessageField(
      {super.key,
      required this.onChanged,
      required this.onSend,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
      onChanged: onChanged,
      cursorHeight: 15.h,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: false,
      cursorColor: Theme.of(context).disabledColor,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
          hintText: 'Enter your message ...',
          hintStyle: TextStyle(
            color: Theme.of(context).iconTheme.color!.withOpacity(.3),
          ),
          prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: IconButton(
                onPressed: onAdd,
                icon: Icon(
                  Iconsax.add,
                  size: 18.h,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                ),
              )),
          suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: IconButton(
                onPressed: onSend,
                icon: Icon(
                  Iconsax.send_1,
                  size: 18.h,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                ),
              )),
          fillColor: Theme.of(context).iconTheme.color!.withOpacity(.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none),
          filled: true),
    );
  }
}

class MessageBar extends StatelessWidget {
  final String name;
  final String photo;
  final String description;
  final void Function() onTap;

  const MessageBar({
    super.key,
    required this.name,
    required this.photo,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Theme.of(context).iconTheme.color!.withOpacity(.05))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                height: 45.h,
                width: 45.h,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: photo,
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
            HGap(width: 17.w),
            SizedBox(
              width: 170.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11.sp)),
                    // VGap(height: 5.h),
                    // Text(description,
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 1,
                    //     style: TextStyle(
                    //         fontSize: 10.sp,
                    //         color: Theme.of(context).disabledColor))
                  ]),
            ),
            const Icon(
              CupertinoIcons.ellipsis_vertical,
              color: Colors.black38,
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final void Function() onLongPress;
  final void Function() onImageTap;
  final bool sender;
  final String text;
  final String imageUrl;
  final bool image;
  final String time;
  final bool seen;
  const MessageTile({
    super.key,
    required this.sender,
    required this.text,
    required this.imageUrl,
    required this.image,
    required this.time,
    required this.seen,
    required this.onImageTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Align(
          alignment: sender ? Alignment.topRight : Alignment.topLeft,
          child: Column(
            crossAxisAlignment:
                sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 250.w,
                ),
                decoration: BoxDecoration(
                    color: image
                        ? Colors.transparent
                        : sender
                            ? Theme.of(context).primaryColor.withOpacity(.8)
                            : Colors.white,
                    border: Border.all(
                        color: image
                            ? Colors.transparent
                            : sender
                                ? Theme.of(context).primaryColor.withOpacity(0)
                                : Colors.black26),
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30),
                        topRight: const Radius.circular(30),
                        bottomRight: Radius.circular(sender ? 0 : 30),
                        bottomLeft: Radius.circular(sender ? 30 : 0))),
                padding: image
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: image
                    ? InkWell(
                        onTap: onImageTap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(30),
                              topRight: const Radius.circular(30),
                              bottomRight: Radius.circular(sender ? 0 : 30),
                              bottomLeft: Radius.circular(sender ? 30 : 0)),
                          child: SizedBox(
                            height: 100.h,
                            width: 100.h,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Load(onTap: () {}),
                              errorWidget: (context, url, error) =>
                                  const Padding(
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
                      )
                    : Text(
                        text,
                        style: TextStyle(
                          color: sender ? Colors.white : Colors.black45,
                          fontWeight: FontWeight.w800,
                          fontSize: 10.sp,
                        ),
                      ),
              ),
              VGap(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment:
                      sender ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 9.sp,
                          color: Colors.black26),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      CupertinoIcons.check_mark,
                      size: 12.h,
                      color: !sender
                          ? Colors.transparent
                          : seen
                              ? Theme.of(context).primaryColor
                              : Colors.black26,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PopUpMenuTile extends StatelessWidget {
  final bool border;
  final String label;
  final void Function() onTap;
  const PopUpMenuTile({
    super.key,
    required this.border,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(border ? .1 : 0)))),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
