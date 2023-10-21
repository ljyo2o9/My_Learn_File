import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Column menuBar() {
  return Column(
    children: [
      Container(
        width: 68.w,
        height: 2.h,
        color: Colors.black,
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Container(
          width: 68.w,
          height: 2.h,
          color: Colors.black,
        ),
      ),
    ],
  );
}
