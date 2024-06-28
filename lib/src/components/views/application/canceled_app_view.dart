import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class CanceledAppView extends StatefulWidget {
  var app;
  CanceledAppView({Key? key, required this.app}) : super(key: key);

  @override
  State<CanceledAppView> createState() => _CanceledAppViewState();
}

class _CanceledAppViewState extends State<CanceledAppView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
            "Заявка",
            // "ID: "+widget.app["id"].toString(),
            style: TextStyle(
              color: Color(0XFF242424),
              fontSize: 18.sp,
             fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "ID: " + widget.app["id"].toString(),
                    style: TextStyle(
                      color: Color(0XFF242424),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: EdgeInsets.all(18.w),
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Имя",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["fullname"].toString().split(" ")[1],
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Фамилия",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["fullname"].toString().split(" ")[0],
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Номер телефона",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["phoneNumber"] ?? "",
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Дата",
                                style: TextStyle(
                                  color: const Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["created_time"]
                                    .toString()
                                    .split("T")[0]
                                    .split("-")
                                    .reversed
                                    .join("/"),
                                // "18/02/2024",
                                style: TextStyle(
                                  color: const Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: const Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Кем",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["status"] == "canceled_by_client"
                                    ? "Клиент"
                                    : widget.app["status"] ==
                                            "canceled_by_scoring"
                                        ? "Скоринг "
                                        : "Сервер",
                                // "Скоринг",
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // if (widget.app["canceled_reason"] != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Статус",
                                    style: TextStyle(
                                      color: const Color(0XFF151522),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    // widget.app["canceled_reason"],
                                    "Отказ",
                                    style: TextStyle(
                                      color: const Color(0xff242424),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Divider(
                              thickness: 1.h,
                              color: Color(0XFF151522).withOpacity(0.1),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
      
      
      
      
      
      
      
      
                        
                        SizedBox(
                          height: 8.h,
                        ),
                        // if (widget.app["canceled_reason"] != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Причина",
                                    style: TextStyle(
                                      color: const Color(0XFF151522),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 260.w,
                                    child: Text(
                                      // widget.app["canceled_reason"],
                                      widget.app["canceled_reason"] ?? "",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: const Color(0xff242424),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Divider(
                              thickness: 1.h,
                              color: Color(0XFF151522).withOpacity(0.1),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/error_bg.png",
                width: 1.sw,
                fit: BoxFit.fitWidth,
                // height: 400.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
