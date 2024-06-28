import 'package:intl/intl.dart';
import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class ProgressAppView extends StatefulWidget {
  var app;
  ProgressAppView({Key? key, required this.app}) : super(key: key);

  @override
  State<ProgressAppView> createState() => _ProgressAppViewState();
}

class _ProgressAppViewState extends State<ProgressAppView> {
  List<String> pages = [
    RouteNames.identificationView,
    RouteNames.customerDataView,
    RouteNames.SelfieWithPassportView,
    RouteNames.scoringView,
    RouteNames.productsView,
    RouteNames.DecorView,
    RouteNames.contractView,
    RouteNames.SelfieWithCheckView,
    RouteNames.GraphicView,
  ];

  List<String> sections = [
    'Идентификация',
    'Данные клиента',
    'Селфи с паспортом',
    'Скоринг',
    'Покупка',
    'Оформление',
    'Договор',
    'Селфи с распиской',
    'График',
  ];
  List<Map> items = [
    {
      "title": "Идентификация",
      "subtitle": "Имя: Xurshid Ismoilov",
      "titleIcon": "person",
      "trailingIcon": true,
      "view": RouteNames.identificationView,
    },
    {
      "title": "Данные клиента",
      "subtitle": "Номер телефона: +998950642827",
      "titleIcon": "database",
      "trailingIcon": true,
      "view": RouteNames.customerDataView,
    },
    {
      "title": "Селфи с паспортом",
      "subtitle": "Завершен",
      "titleIcon": "camera",
      "trailingIcon": true,
      "view": RouteNames.SelfieWithPassportView,
    },
    {
      "title": "Скоринг",
      "subtitle": "ОДОБРЕНА по завершенным условиям\nЛимит: 6 000 000 сум",
      "titleIcon": "check-square",
      "trailingIcon": true,
      "view": RouteNames.scoringView,
    },
    {
      "title": "Покупка",
      "subtitle": "Товаров выбрано: 1\nОбщая сумма: 2 500 000 сум",
      "titleIcon": "shopping-bag",
      "trailingIcon": true,
      "view": RouteNames.productsView,
    },
    {
      "title": "Оформление",
      "subtitle":
          "Выбранный период: 9 месяцев\nОбщая сумма с рассрочки: 3 250 000 сум",
      "titleIcon": "file-text",
      "trailingIcon": true,
      "view": RouteNames.DecorView,
    },
    {
      "title": "Селфи с распиской",
      "subtitle": "Завершен",
      "titleIcon": "camera",
      "trailingIcon": true,
      "view": RouteNames.SelfieWithCheckView,
    },
    {
      "title": "Договор",
      "subtitle": "Дата погашения: 14 октября 2023 г",
      "titleIcon": "clipboard",
      "trailingIcon": true,
      "view": RouteNames.contractView,
    },
    {
      "title": "График",
      "subtitle": "Завершен",
      "titleIcon": "calendar",
      "trailingIcon": true,
      "view": RouteNames.GraphicView,
    },
  ];

  // AppModel? appModel;
  @override
  void initState() {
    // appModel = AppModel.fromJson(widget.app);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      AppController.refresh(context);
    });
    super.initState();
  }

  Timer? _timer;
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.app);
    // HiveService.createZayavka(widget.app);
    // print(HiveService.getZayavka(widget.app["id"].toString()));
    // print(HiveService.getZayavka("11"));
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<GetAppsBloc, GetAppsState>(
      builder: (context, state) {
        if (!(state is GetAppsSuccessState)) {
          return Container();
        }
        List apps = state.apps;
        print("widget.app");
        print(widget.app);
        final appModel = apps[apps.indexWhere((element) =>
            element["id"].toString() == widget.app["id"].toString())];
        print(apps.indexWhere((element) =>
            element["id"].toString() == widget.app["id"].toString()));
        print(appModel);
        var status = appModel["status"];

        Future.delayed(
            Duration(
              seconds: 1,
            ), () {
          if (mounted) {
            if (status == "progress") {
              _timer?.cancel();
              _timer = null;
            }
            if (status == "canceled_by_client" ||
                status == "canceled_by_scoring" ||
                status == "canceled_by_daily") {
              Navigator.popAndPushNamed(context, RouteNames.canceledAppView,
                  arguments: {"app": appModel});
            } else if (status == "finished" || status == "paid") {
              Navigator.popAndPushNamed(
                context,
                RouteNames.finishedAppView,
                arguments: {
                  "app": appModel,
                },
              );
            }
          }
        });

        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: customAppBar(
              context,
              "Заявка",
              action: [
                if (appModel?["id"] != null)
                  Center(
                    child: Text(
                      "ID: " + appModel!["id"].toString(),
                      style: TextStyle(
                        color: Color(0XFF242424),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
            body: RefreshIndicator(
              displacement: 60.h,
              backgroundColor: AppConstant.primaryColor,
              color: Colors.white,
              strokeWidth: 2.h,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                // check1 = [true, true, true];
                // hasCalendar = false;
                // setState(() {});
                await AppController.refresh(
                  context,
                );
              },
              child: Container(
                width: 1.sw,
                height: 1.sh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  // padding: EdgeInsets.only(
                  //   // left: 16.w,
                  //   // right: 16.w,
                  //   top: 12.h,
                  //   bottom: 32.h,
                  // ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(6.r),
                        //   border: Border.all(
                        //     width: 1.sp,
                        //     color: const Color(0xffE8E8E8),
                        //   ),
                        // ),
                        // margin: EdgeInsets.all(16.w),
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            Column(children: [
                              ...List.generate(
                                items.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    if (appModel?["step"] == index ||
                                        (appModel?["step"] > 4 && index == 4)) {
                                      if (mounted) {
                                        Navigator.pushNamed(
                                          context,
                                          items[index]["view"],
                                          arguments: {
                                            "appModel": appModel,
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: itemCard(
                                      title: items[index]["title"],
                                      subtitle: customText(appModel!, index),
                                      trailingIcon: appModel!["step"]! > index,
                                      index: index,
                                      titleiconPath:
                                          "assets/icons/${items[index]["titleIcon"]}.svg",
                                      app: appModel),
                                ),
                              ),
                            ]
                                // List.generate(
                                //   pages.length,
                                //   (index) {
                                //     return GestureDetector(
                                //       onTap: () {
                                //         print(index);
                                //        Navigator.pushNamed(context, pages[index],
                                //               arguments: {
                                //                 "appModel": appModel,
                                //               });
                                //         // if (appModel["step"] == index ||
                                //         //     (appModel["step"] == 5 && index == 4)) {
                                //         //   Navigator.pushNamed(context, pages[index],
                                //         //       arguments: {
                                //         //         "appModel": appModel,
                                //         //       });
                                //         // }
                                //       },
                                //       child: Container(
                                //         margin: EdgeInsets.only(bottom: 10.h),
                                //         padding:
                                //             EdgeInsets.symmetric(horizontal: 16.w),
                                //         height: 62.h,
                                //         decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           borderRadius: BorderRadius.circular(6.r),
                                //           border: Border.all(
                                //             width: 1.sp,
                                //             color: const Color(0xffE8E8E8),
                                //           ),
                                //         ),
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.spaceAround,
                                //               children: [
                                //                 Text(
                                //                   sections[index],
                                //                   style: TextStyle(
                                //                     color:
                                //                         (appModel?["step"] ?? 0) >=
                                //                                 index
                                //                             ? Colors.black
                                //                             : Colors.grey,
                                //                     fontSize: 16.sp,
                                //                     fontWeight: FontWeight.w500,
                                //                   ),
                                //                 ),
                                //                 if (customText(appModel, index) !=
                                //                     null)
                                //                   SizedBox(
                                //                     width: 240.w,
                                //                     child: Text(
                                //                       customText(appModel, index)!,
                                //                       style: TextStyle(
                                //                         color: Colors.grey,
                                //                         fontSize: 11.sp,
                                //                         fontWeight: FontWeight.w500,
                                //                       ),
                                //                     ),
                                //                   ),
                                //               ],
                                //             ),
                                //             if(appModel?["step"] == 3 && index == 3)
          
                                //                    Transform.scale(
                                //                       scale: 2,
                                //                       child: Lottie.asset(
                                //                         "assets/animations/scoring.json",
                                //                         height: 30.h,
                                //                       ),
                                //                     )
                                //                   ,
                                //             if ((appModel?["step"] ?? 0) > index)
                                //               Icon(
                                //                       Icons.check_rounded,
                                //                       color: Colors.green,
                                //                       size: 30.h,
                                //                     ),
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
          
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemCard(
      {required String title,
      required String subtitle,
      required String titleiconPath,
      required bool trailingIcon,
      required int index,
      required app}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          width: 325.w,
          child: Row(
            children: [
              Container(
                height: 40.w,
                width: 40.w,
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: Color(0xffE4E4E4).withOpacity(0.3),
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   width: 1.w,
                  //   color: Color(0xFF999999),
                  // ),
                ),
                child: SvgPicture.asset(
                  titleiconPath,
                  // ignore: deprecated_member_use
                  color: Color(0XFFBE52F2),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: 242.w,
                // height: 55.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: app!["step"] >= index
                            ? Color(0Xff242424)
                            : Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: index == 3 && app!["step"] == 4
                              ? Color(0xff00C48C)
                              : Color(0Xff242424).withOpacity(0.6),
                          fontWeight: index == 3 && app!["step"] == 4
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 11.sp,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: trailingIcon
                      ? Transform.scale(
                          scale: 1.4,
                          child: SvgPicture.asset("assets/icons/check.svg",
                              fit: BoxFit.cover),
                        )
                      : null)
            ],
          ),
        ),

        // ListTile(
        //   dense: true,
        //   leading:
        //    Container(
        //     height: 40.h,
        //     width: 40.h,
        //     padding: EdgeInsets.all(8.h),
        //     decoration: BoxDecoration(
        //       color: Color(0xffE4E4E4).withOpacity(0.3),
        //       shape: BoxShape.circle,
        //       // border: Border.all(
        //       //   width: 1.w,
        //       //   color: Color(0xFF999999),
        //       // ),
        //     ),
        //     child: SvgPicture.asset(
        //       titleiconPath,

        //       color: Color(0XFFBE52F2),
        //     ),
        //   ),
        //   title: Text(
        //     title,
        //     style: TextStyle(
        //       color: Color(0Xff242424),
        //       fontWeight: FontWeight.w500,
        //       fontSize: 13.sp,
        //     ),
        //   ),
        //   subtitle: Text(
        //     subtitle,
        //     style: TextStyle(
        //       color: Color(0Xff242424).withOpacity(0.6),
        //       fontWeight: FontWeight.w400,
        //       fontSize: 11.sp,
        //     ),
        //   ),
        //   trailing:trailingIcon  ? Transform.scale(
        //     scale: 1.4,
        //     child: SvgPicture.asset("assets/icons/check.svg", fit: BoxFit.cover),
        //   ):null,
        // ),

        Divider(
          color: Color(0xFFE4E4E4).withOpacity(0.3),
          thickness: 1,
        ),
      ],
    );
  }
}

String customText(Map? app, int index) {
  if (app == null) {
    return "";
  }
  if (app["step"] > index) {
    if (index == 0) {
      return "Паспорт серии : " +
          app["passport"].toString().substring(0, 2) +
          "\nПасспорт номер : " +
          heshPassport(app["passport"].toString().substring(2));
    } else if (index == 1) {
      return "Имя : " +
          app["fullname"] +
          "\n" +
          "Номер телефона : " +
          heshPhoneNumber(app["phoneNumber"]);
    } else if (index == 3) {
      return "Одобрена по завершенным условиям,\nЛимит : " +
          toMoney(app["limit_summa"]) +
          " сум";
    } else if (index == 4) {
      if (app["products"] == null) return "";
      return "Товаров выбрано : " +
          app["products"].length.toString() +
          ",\nОбщая сумма : " +
          toMoney(app["amount"]) +
          " сум";
    } else if (index == 5) {
      return "Выбранный период :" +
          app["expired_month"].toString() +
          " месяцев,\nОбщая сумма с рассрочки: " +
          toMoney(app["payment_amount"]) +
          " сум";
    } else if (index == 7) {
      return "PPD-" +
          app["id"].toString() +
          " Онлайн Электрон Оферта : " +
          customDate(app["created_time"].toString()) +
          " г";
    }
  }
  if (app["step"] == 8 && index == 8) {
    return "Ежемесячный платеж : " +
        toMoney((app["payment_amount"] / app["expired_month"]).toInt()) +
        " сум";
  }
  return "";
}

customDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('d MMMM  y', 'ru_RU').format(dateTime);
}
