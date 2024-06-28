import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customBottomSheet(BuildContext context, Widget widget) async {
  return await showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: widget,
        ),
      );
    },
  );
}
