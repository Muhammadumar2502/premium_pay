import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future calendarBottomSheet(BuildContext context) async {
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
      return StatefulBuilder(builder: (context, sets) {
        return SizedBox(
          height: 500.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Календарь",
                      style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Отмена",
                        style: TextStyle(
                          color: Color(0xFFBE52F2),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 0.1.h),
                SizedBox(height: 24.h),
                Column(
                  children: [
                    Container(
                      height: 280.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          width: 1.sp,
                          color: const Color(0xffE8E8E8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2.r,
                            blurRadius: 4.r,
                            offset:
                                Offset(0, 3.h), // changes position of shadow
                          ),
                        ],
                      ),

                      // Calendar pack
                      child: SfDateRangePicker(
                        onSelectionChanged:
                            (dateRangePickerSelectionChangedArgs) {
                          // startDate = dateRangePickerSelectionChangedArgs
                          //     .value.startDate
                          //     .toString();
                          sets(() {});
                        },
                        headerHeight: 80.h,
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        minDate: DateTime.utc(2010, 01, 01),
                        maxDate: DateTime.utc(2050, 01, 01),
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xFFBE52F2),
                    fixedSize: Size(MediaQuery.of(context).size.width, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Применить",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      });
    },
  );
}
