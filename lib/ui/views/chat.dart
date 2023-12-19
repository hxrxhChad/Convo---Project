import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/widgets.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          VGap(height: 15.h),
          ChatViewHeader(onTap: () {}),
          VGap(height: 15.h),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 10.h),
                      child: Row(children: [
                        Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: const BoxDecoration(
                                color: Colors.black12, shape: BoxShape.circle)),
                        HGap(width: 20.w),
                        SizedBox(
                          width: 220.w,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Faker().person.name(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                VGap(height: 5.h),
                                Text(Faker().lorem.sentence(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Theme.of(context).disabledColor))
                              ]),
                        ),
                      ]),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
