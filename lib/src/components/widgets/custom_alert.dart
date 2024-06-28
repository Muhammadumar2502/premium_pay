import 'package:premium_pay_new/export_files.dart';

customAlertDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
        content: Container(
          height: 390.h,
          width: 300.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Image.asset(
                "assets/logo_2.png",
                height: 85.h,
                width: 200.w,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "Вы действительно хотите выйти?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Column(
                children: [
                  customButton(
                    context,
                    'Нет',
                    () {
                      Navigator.of(context).pop();
                    },
                    Color(0xFFBE52F2),
                  ),
                  SizedBox(height: 15.h),
                  customButton(
                    context,
                    'Да',
                    () {
                      Future.wait([
                        CacheService.remove(
                          CacheService.token,
                        ),
                        CacheService.remove(
                          CacheService.user,
                        )
                      ]);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.login,
                        (route) => false,
                      );
                    },
                    Colors.grey.shade400,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
