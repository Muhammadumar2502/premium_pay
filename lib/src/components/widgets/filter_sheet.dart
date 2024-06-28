import 'package:premium_pay_new/export_files.dart';

filterWidget<Widget>(List<bool> check1Local) {
  List<String> statusString = [
    'Завершен',
    'Ожидающий',
    'Отказано',
  ];
  List<Color> color = [
    const Color(0xFF00C48C),
    const Color(0xFFFFCF5C),
    const Color(0xFFFF647C),
  ];

  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        height: 390.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Фильтр",
                    style: TextStyle(
                      color: Color(0xFF4F4F4F),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
              Divider(
                thickness: 0.1,
              ),
              SizedBox(height: 16.h),
              Column(
                children: List.generate(
                  statusString.length,
                  (index) {
                    return Container(
                      child: CheckboxListTile(
                        activeColor: Color(0xFFBE52F2),
                        side: BorderSide(width: 0.2.w),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          statusString[index],
                          style: TextStyle(
                            color: color[index],
                            fontSize: 16.sp,
                            height: 1.5.h,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        value: check1Local[index],
                        onChanged: (value) {
                          setState(
                            () {
                              check1Local[index] = value!;
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        check1Local = [false, false, false];
                        setState(
                          () {},
                        );
                      },
                      child: Text(
                        "Очистить",
                        style: TextStyle(
                          color: Color(0xFFBE52F2),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  customButton(context, 'Применить', () {
                    if ((check1Local[0] || check1Local[1] || check1Local[2])) {
                      Navigator.of(context).pop(check1Local);
                    }
                  },
                      (check1Local[0] || check1Local[1] || check1Local[2])
                          ? AppConstant.primaryColor
                          : Colors.grey.shade400
                      // Colors.white,
                      ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      );
    },
  );
}
