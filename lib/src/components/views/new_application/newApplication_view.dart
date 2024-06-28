import 'package:premium_pay_new/export_files.dart';

class NewApplicationView extends StatefulWidget {
  NewApplicationView({Key? key}) : super(key: key);

  @override
  State<NewApplicationView> createState() => _NewApplicationViewState();
}

class _NewApplicationViewState extends State<NewApplicationView> {
  String? fullname;
  String? phoneNumber;
  Timer? _timer;
  @override
  void initState() {
    _timer =Timer.periodic(Duration(seconds: 5), (timer) {
      final state =BlocProvider.of<GetAppsBloc>(context).state;
      if (state is GetAppsSuccessState) {
        if (state.apps.last["id"] !=null) {
          AppController.refresh(context);
        }else{
          print("no refresh");
        }
      }
       
     });
    super.initState();
    CacheService.read(
      CacheService.user,
    ).then((user) {
      fullname = user["fullName"];
      phoneNumber = user["phoneNumber"];
      setState(() {});
    });
    AppController.add(context);
  }
   @override
  void dispose() { 
    super.dispose();
    _timer?.cancel();
  }

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // AppModel appModel = AppModel();
  Map? appModel = null;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAppsBloc, GetAppsState>(builder: (context, state) {
      if (!(state is GetAppsSuccessState)) {
        return Container();
      }

      if (appModel?["step"] == null) {
        print("if");

        appModel = {
          "id": null,
          "merchant_id": null,
          "user_id": null,
          "fullname": null,
          "phoneNumber": null,
          "phoneNumber2": null,
          "cardNumber": null,
          "passport": null,
          "status": null,
          "canceled_reason": null,
          "device": null,
          "location": null,
          "products": null,
          "amount": null,
          "payment_amount": null,
          "expired_month": null,
          "created_time": null,
          "finished_time": null,
          "bank": 'Davr',
          "selfie": null,
          "agree": null,
          "step": 0,
          "myidInfo": null,
        };
      } else if (appModel?["step"] == 0) {
        print("else if");
        appModel = state.apps.last;
      } else {
        print("else");
        List apps = state.apps;
        appModel = apps[apps.indexWhere((element) =>
            element["id"].toString() == appModel!["id"].toString())];
        print(apps.indexWhere((element) =>
            element["id"].toString() == appModel!["id"].toString()));
      }
      print(appModel);
      var status = appModel?["status"];

      Future.delayed(
          Duration(
            seconds: 1,
          ), () {
        if (mounted) {
          if (status =="progress") {
            _timer?.cancel();
            _timer=null;
          }
          if (status == "canceled_by_client" ||
            status == "canceled_by_scoring" ||
            status == "canceled_by_daily") {
          Flushbar(
            backgroundColor: Colors.red.shade700,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            message: "Заявление отменено",
            messageColor: Colors.white,
            messageSize: 18.sp,
            icon: Icon(
              Icons.error,
              size: 28.0,
              color: Colors.white,
            ),
            duration: Duration(minutes:1),
            leftBarIndicatorColor: Colors.red.shade700,
          ).show(context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.applicationView,
            (r) => false,
          );
        } else if (status == "finished" || status == "paid") {
          Flushbar(
            backgroundColor: Colors.green.shade700,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            message: "Заявление закончен",
            messageColor: Colors.white,
            messageSize: 18.sp,
            icon: Icon(
              Icons.check,
              size: 28.0,
              color: Colors.white,
            ),
            duration: Duration(minutes:1),
            leftBarIndicatorColor: Colors.green.shade700,
          ).show(context);

          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   RouteNames.applicationView,
          //   (r) => false,
          // );
        }
        }
      });

      print(">>>>>>>>>>> state ${appModel?['step']}  ");

      return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: customDrawer(
            fullname: fullname,
            phoneNumber: phoneNumber,
          ),
          endDrawerEnableOpenDragGesture: false,
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
              "Новая заявка",
              style: TextStyle(
                color: Color(0XFF242424),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.all(18.w),
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                  ),
                ),
              ),
            ),
            actions: [
              if (appModel?["id"] != null)
                Center(
                  child: Text(
                    "ID: " + appModel!["id"].toString(),
                    style: TextStyle(
                      color: Color(0XFF242424),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
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
              if ((appModel?["step"] ?? 0) > 0) {
                await AppController.refresh(
                  context,
                );
              }
            },
            child: Container(
              width: 1.sw,
              height: 1.sh,
              child: AnimationLimiter(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  // padding: EdgeInsets.only(
                  //   left: 16.w,
                  //   right: 16.w,
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
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            Column(children: [
                              ...List.generate(
                                items.length,
                                (index) => AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: Duration(milliseconds: 150),
                                  child: SlideAnimation(
                                    duration: Duration(milliseconds: 2500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: FadeInAnimation(
                                      duration: Duration(milliseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (appModel?["step"] == index ||
                                              (appModel?["step"] > 4 && index == 4)  ) {
                                            Navigator.pushNamed(
                                                context, items[index]["view"],
                                                arguments: {
                                                  "appModel": appModel,
                                                });
                                          }
                                        },
                                        child: itemCard(
                                          title: items[index]["title"],
                                          subtitle: customText(appModel, index),
                                          trailingIcon: (appModel?["step"] ?? 0) > index,
                                          index: index,
                                          titleiconPath:
                                              "assets/icons/${items[index]["titleIcon"]}.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                                //  List.generate(
                                //   pages.length,
                                //   (index) {
                                //     return GestureDetector(
                                //       onTap: () async {
                                //         if (appModel?["step"] == index ||
                                //             (appModel?["step"] == 5 && index == 4)) {
                                //           final data = await Navigator.pushNamed(
                                //               context, pages[index],
                                //               arguments: {
                                //                 "appModel": appModel,
                                //                 "isAvailable": true,
                                //                 //   "myidInfo": myidInfo,
                                //                 //   "birthDate":
                                //                 //       "${selectedDate.toLocal()}".split(' ')[0]
                                //               });
                                //           print(">>>");
                                //           print(data);
                                //           if (data != null) {
                                //             // appModel = AppModel.fromJson(data as Map);
                                //             setState(() {});
                                //           }
                                //           print(data);
                                //         }
                                //       },
                                //       child:
                
                                //       Container(
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
                                //                     color: (appModel?["step"] ?? 0) >=
                                //                             index
                                //                         ? Colors.black
                                //                         : Colors.grey,
                                //                     fontSize: 16.sp,
                                //                     fontWeight: FontWeight.w500,
                                //                   ),
                                //                 ),
                                //                 if (customText(appModel!, index) !=
                                //                     null)
                                //                   SizedBox(
                                //                     width: 240.w,
                                //                     child: Text(
                                //                       customText(appModel!, index)!,
                                //                       style: TextStyle(
                                //                         color: Colors.grey,
                                //                         fontSize: 11.sp,
                                //                         fontWeight: FontWeight.w500,
                                //                       ),
                                //                     ),
                                //                   ),
                                //               ],
                                //             ),
                                //             if (appModel?["step"] == 3 && index == 3)
                                //               Transform.scale(
                                //                 scale: 2,
                                //                 child: Lottie.asset(
                                //                   "assets/animations/scoring.json",
                                //                   height: 32.h,
                                //                 ),
                                //               ),
                                //             if ((appModel?["step"] ?? 0) > index)
                                //               Icon(
                                //                 Icons.check_rounded,
                                //                 color: Colors.green,
                                //                 size: 30.h,
                                //               ),
                                //           ],
                                //         ),
                
                                //         //  Row(
                                //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //         //   children: [
                
                                //         //     Text(
                                //         //       sections[index],
                                //         //       style: TextStyle(
                                //         //         color: appModel["step"]! >= index
                                //         //             ? Colors.black
                                //         //             : Colors.grey,
                                //         //         fontSize: 16.sp,
                                //         //         fontWeight: FontWeight.w500,
                                //         //       ),
                                //         //     ),
                
                                //         //     if (appModel["step"]! > index)
                                //         //       Icon(
                                //         //         Icons.check_rounded,
                                //         //         color: Colors.green,
                                //         //         size: 30.h,
                                //         //       )
                                //         //   ],
                                //         // ),
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
        ),
      );
    });
  }

  Widget itemCard(
      {required String title,
      required String subtitle,
      required String titleiconPath,
      required bool trailingIcon,
      required int index}) {
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
                        color: (appModel?["step"] ?? 0) >= index
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
                          color:index ==3 &&  appModel!["step"] ==4 ?  Color(
                                                                    0xff00C48C) :  Color(0Xff242424).withOpacity(0.6),
                          fontWeight:index ==3 &&  appModel!["step"] ==4 ? FontWeight.w600: FontWeight.w400,
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
