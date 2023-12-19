import 'package:chat_alpha_sept/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HallPage extends StatelessWidget {
  const HallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: Routes.routes().length,
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 30.w),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: InkWell(
            onTap: () =>
                Navigator.pushNamed(context, Routes.routes()[index].route),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(20.w),
              child: Text(
                Routes.routes()[index].page.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
