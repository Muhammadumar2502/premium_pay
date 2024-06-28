// ignore_for_file: deprecated_member_use

import 'package:premium_pay_new/export_files.dart';


class InfoView extends StatefulWidget {
  InfoView({Key? key,}) : super(key: key);
  // String section;

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Color(0xFFE4E4E4).withOpacity(0.6),
                height: 1.0,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Инфо",
              style: TextStyle(
                color: Color(0XFF242424),
                fontSize: 18.sp,
               fontWeight: FontWeight.w600,
              ),
            ),
            leading: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo_2.png",
                          width: 215.w,
                        ),
                      ],
                    ),
                    Text(
                      "Версия 1.0.0",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff6F7977),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: 325.w,
                  child: Text(
                    "Как вы оцениваете приложение?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff151522),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  width: 325.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/star.svg",
                        color: Color(0xffFFD700),
                        width: 40.w,
                      ),
                      SvgPicture.asset(
                        "assets/icons/star.svg",
                        color: Color(0xffFFD700),
                        width: 40.w,
                      ),
                      SvgPicture.asset(
                        "assets/icons/star.svg",
                        color: Color(0xffFFD700),
                        width: 40.w,
                      ),
                      SvgPicture.asset(
                        "assets/icons/star.svg",
                        color: Color(0xffFFD700),
                        width: 40.w,
                      ),
                      SvgPicture.asset(
                        "assets/icons/star.svg",
                        color: Color(0xffE4E4E4),
                        width: 40.w,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  width: 325.w,
                  child: Text(
                    "Пожалуйста, поделитесь своим мнением о продукте",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff151522),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 325.w,
                          // height: 50.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 6.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                              width: 1.w,
                              color: Color(0xffE4E4E4),
                            ),
                          ),
                          child: TextField(
                            maxLines: 7,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                                height: 1),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              isDense: true,
                              border:
                                  OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 327.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xffBE52F2),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff323247).withOpacity(0.3),
                                  offset: Offset(0, 4.h),
                                  blurRadius: 4.r,
                                  // blurStyle: BlurStyle.outer
                                ),
                              ]),
                          child: Text(
                            "Оценить приложение",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
 }
}
