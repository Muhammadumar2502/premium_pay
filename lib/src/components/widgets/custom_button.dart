import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customButton<Widget>(
    BuildContext context, String text, VoidCallback onPressed, Color color,
    {Color textColor = Colors.white, Color? sideColor, double? buttonWidth}) {
  return Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 3,
        shadowColor: Colors.transparent,
        fixedSize: Size(buttonWidth ?? 160.w, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
          side: BorderSide(
              color: sideColor == null ? Colors.transparent : sideColor),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  );
}

// customButton<Widget>(BuildContext context, String text, VoidCallback onPressed, Color color) {
//   return Center(
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shadowColor: Colors.transparent,
//         fixedSize: Size(MediaQuery.of(context).size.width, 50.h),
//       ),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16.sp,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     ),
//   );
// }
