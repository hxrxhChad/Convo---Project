import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/widgets.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          VGap(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(.05))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: const BoxDecoration(
                          color: Colors.black12, shape: BoxShape.circle)),
                  HGap(width: 20.w),
                  SizedBox(
                    width: 170.w,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Faker().person.name(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          VGap(height: 5.h),
                          Text('Last active on 10:37 PM',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Theme.of(context).disabledColor))
                        ]),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.ellipsis_vertical,
                        color: Colors.black38,
                      ))
                ],
              ),
            ),
          ),
          // VGap(height: 15.h),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Align(
                    alignment:
                        index % 2 == 0 ? Alignment.topRight : Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: index % 2 == 0
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 250.w,
                          ),
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.8)
                                  : Colors.white,
                              border: Border.all(
                                  color: index % 2 == 0
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0)
                                      : Colors.black26),
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30),
                                  topRight: const Radius.circular(30),
                                  bottomRight:
                                      Radius.circular(index % 2 == 0 ? 0 : 30),
                                  bottomLeft: Radius.circular(
                                      index % 2 == 0 ? 30 : 0))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          child: Text(
                            Faker().lorem.sentence(),
                            style: TextStyle(
                              color: index % 2 != 0
                                  ? Colors.black45
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        VGap(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            '10:35 PM',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12.sp,
                                color: Colors.black26),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
              child: MessageField(onChanged: (v) {}))
        ]),
      ),
    );
  }
}
