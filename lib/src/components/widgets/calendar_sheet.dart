import 'package:premium_pay_new/export_files.dart';

Future calendarBottomSheet(
    BuildContext context, DateTime? startDate, DateTime? endDate) async {
  String? startDateStr;
  String? endDateStr;

  return await Promise.run((resolve, reject)async {
      
 
     
    var data =  await showModalBottomSheet(
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
          height: 460.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                // qora chiziq
                Container(
                  width: 60.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
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
                      ),

                      // Calendar pack
                      child: SfDateRangePicker(
                        onSelectionChanged:
                            (dateRangePickerSelectionChangedArgs) {
                          startDateStr = dateRangePickerSelectionChangedArgs
                              .value.startDate
                              .toString();
                          endDateStr = dateRangePickerSelectionChangedArgs
                              .value.endDate
                              .toString();

                          sets(() {});
                        },
                        view: DateRangePickerView.month,
                        initialSelectedRange:
                            PickerDateRange(startDate, endDate),
                        selectionMode: DateRangePickerSelectionMode.range,
                        minDate: DateTime.utc(2010, 01, 01),
                        maxDate: DateTime.utc(2050, 01, 01),
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                customButton(context, 'Применить', () {
                  if (startDateStr != null || endDateStr != null) {
                   
                    Navigator.of(context)
                        .pop({"startDate": startDateStr, "endDate": endDateStr});
                        

                  }
                },
                    startDateStr != null || endDateStr != null
                        ? AppConstant.primaryColor
                        : Colors.grey.shade400,
                    buttonWidth: MediaQuery.of(context).size.width),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      });
    },
  );
    
    if (data !=null) {
       resolve(data);
    }else{
      resolve(null);
    }
    });

  // if (data != null) {
  //   Navigator.of(context)
  //     .pop(
  //       // {"startDate": startDateStr, "endDate": endDateStr}
  //       data
  //       );
  // // }

}
