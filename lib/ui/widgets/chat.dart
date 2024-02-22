import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets.dart';

class ChatViewHeader extends StatelessWidget {
  final void Function() onTap;
  final void Function() onTapAdd;

  const ChatViewHeader({
    super.key,
    required this.onTap,
    required this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: onTap,
          child: Text('Convo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        ),
        AuthButtonSmall(label: 'Add', onTap: onTapAdd, outlined: false)
      ]),
    );
  }
}

class SearchViewHeader extends StatelessWidget {
  final void Function() onTap;
  final void Function(String) onChanged;

  const SearchViewHeader({
    super.key,
    required this.onTap,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
        onChanged: onChanged,
        cursorHeight: 15.h,
        textAlignVertical: TextAlignVertical.center,
        autocorrect: false,
        cursorColor: Theme.of(context).disabledColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.w),
            hintText: 'Search here',
            hintStyle: TextStyle(
              color: Theme.of(context).iconTheme.color!.withOpacity(.3),
            ),
            suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    CupertinoIcons.multiply,
                    size: 18.h,
                    color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  ),
                )),
            fillColor: Theme.of(context).iconTheme.color!.withOpacity(.03),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none),
            filled: true),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final void Function() onTap;
  final String imageUrl;
  final String name;
  final String description;
  const SearchTile({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: 45.h,
              width: 45.h,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
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
          HGap(width: 20.w),
          SizedBox(
            width: 220.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp)),
              VGap(height: 5.h),
              Text(description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 10.sp, color: Theme.of(context).disabledColor))
            ]),
          ),
        ]),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final void Function() onTap;
  final String otherParticipantId;
  final String chatId;
  const ChatTile({
    super.key,
    required this.onTap,
    required this.otherParticipantId,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: Row(children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(otherParticipantId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  // Check if data is available and not null
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final photo = userData['photo'] ?? 'Unknown';
                  return ClipRRect(
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
                  );
                }
                return SizedBox(
                  height: 45.h,
                  width: 45.h,
                );
              }),
          HGap(width: 20.w),
          SizedBox(
            width: 220.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(otherParticipantId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // Check if data is available and not null
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final name = userData['name'] ?? 'Unknown';
                      return Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11.sp));
                    }
                    return Text('loading name ...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11.sp));
                  }),
              VGap(height: 5.h),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .where('chatId', isEqualTo: chatId)
                      .orderBy('time', descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final content = snapshot.data!.docs.first['content'];
                      final type = snapshot.data!.docs.first['type'];
                      return type == 'image'
                          ? Row(
                              children: [
                                const Icon(
                                  Iconsax.image,
                                  color: Colors.blue,
                                  size: 11,
                                ),
                                const HGap(width: 5),
                                Text('image',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Theme.of(context).disabledColor))
                              ],
                            )
                          : Text(content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Theme.of(context).disabledColor));
                    }
                    return Text('loading your message ...',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Theme.of(context).disabledColor));
                  })
            ]),
          ),
        ]),
      ),
    );
  }
}
