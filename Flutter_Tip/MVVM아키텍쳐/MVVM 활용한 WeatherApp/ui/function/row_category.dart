import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Row rowCategory(dynamic a, dynamic b) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      //
      /// 풍속
      Text(
        a,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.3.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
      //
      /// 강수 확률
      Text(
        b,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.3.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
