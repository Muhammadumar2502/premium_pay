// ignore_for_file: deprecated_member_use

import 'package:premium_pay_new/src/core/extensions/date_extension.dart';
import 'package:premium_pay_new/export_files.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  List<String> statusText = [
    'Завершен',
    'Ожидающий',
    'Отказано',
  ];
  // List<Color> color = [
  //   const Color(0xFF1BDA17),
  //   const Color(0xFFECA400),
  //   const Color(0xFFDA2222),
  // ];
  List<String> status = [
    "assets/icons/check.svg",
    "assets/icons/cancel.svg",
    "assets/icons/clock.svg",
  ];
  List<Color> color = [
    const Color(0xFF00C48C),
    const Color(0xFFFFCF5C),
    const Color(0xFFFF647C),
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? fullname;
  String? phoneNumber;

  @override
  void initState() {
    AppController.get(
      context,
    );

    PercentsController.get(context);

    CacheService.read(
      CacheService.user,
    ).then((user) {
      fullname = user == null ? "" : user?["fullName"];
      phoneNumber = user ==null ? "" : user["phoneNumber"];
      setState(() {});
    });

    super.initState();
  }

  List<bool> check1 = [true, true, true];
  var dataRange;

  bool hasCalendar = false;
  DateTime? startTime;
  DateTime? endTime;
  bool sortByDate(Map? appMod) {
    if (appMod ==null) {
       return false;
    }
    if (appMod["created_time"] ==null) {
      return false;
    }
    return DateTime.parse(appMod["created_time"])
                .compareTo(startTime ?? DateTime(2000)) >
            -1 &&
        DateTime.parse(appMod["created_time"])
                .compareTo(endTime ?? DateTime(2050)) <
            1;
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<GetAppsBloc, GetAppsState>(
      builder: (context, state) {
        List? apps;
        if (state is GetAppsIntialState || state is GetAppsWaitingState) {
          apps = null;
        } else if (state is GetAppsErrorState) {
          apps = [];
        } else if (state is GetAppsSuccessState) {
          List appsList = [];
          List appsState = state.apps;
    
          for (var i = 0; i < appsState.length; i++) {
            // print(appsState[i]["status"]);
    
            if (sortByDate(appsState[i])) {
              if (check1[0] &&
                  (appsState[i]["status"] == "finished" ||
                      appsState[i]["status"] == "paid")) {
                appsList.add(appsState[i]);
              }
              if (check1[1] && appsState[i]["status"] == "progress") {
                appsList.add(appsState[i]);
              }
              if (check1[2] &&
                  (appsState[i]["status"] == "canceled_by_daily" ||
                      appsState[i]["status"] == "canceled_by_scoring" ||
                      appsState[i]["status"] == "canceled_by_client")) {
                appsList.add(appsState[i]);
              }
            }
          }
    
          // print(appsList.length);
          apps = appsList;
        }
        // print(state);
        return SafeArea(
          child: Scaffold(
            // endDrawerEnableOpenDragGesture: false,
            // drawerEnableOpenDragGesture: false,
            drawer: customDrawer(
              fullname: fullname,
              phoneNumber: phoneNumber,
            ),
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: true,
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
                "Заявки",
                style: TextStyle(
                  color: Color(0XFF242424),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Builder(
                builder: (context) => GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: SvgPicture.asset(
                      'assets/icons/menu.svg',
                      color: Color(0xff999999),
                    ),
                  ),
                ),
              ),
              actions: [
                BlocListener<GetAppsBloc, GetAppsState>(
                  listener: (context, state) {
                    if (state is GetAppsSuccessState) {
                      // writeApps(state.apps);
                    } else if (state is GetAppsErrorState) {
                      if (state.statusCode == 401) {
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
                      }
                      Flushbar(
                        backgroundColor: Colors.red.shade700,
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        flushbarPosition: FlushbarPosition.TOP,
                        flushbarStyle: FlushbarStyle.GROUNDED,
                        isDismissible: true,
                        message: "Пожалуйста, войдите снова",
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
                    }
                  },
                  child: SizedBox(),
                ),
                GestureDetector(
                  onTap: () {
                    if (BlocProvider.of<GetAppsBloc>(context).state
                        is GetAppsSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchView(
                            apps: apps,
                          ),
                        ),
                      );
                    } else {
                      Flushbar(
                        backgroundColor: Colors.red.shade700,
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        flushbarPosition: FlushbarPosition.TOP,
                        flushbarStyle: FlushbarStyle.GROUNDED,
                        isDismissible: true,
                        message: "Нет связи с сервером",
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
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 20.w,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var dates =
                        await calendarBottomSheet(context, startTime, endTime);
                    if (dates != null) {
                      startTime = DateTime.tryParse(dates["startDate"] ?? "");
                      endTime = DateTime.tryParse(dates["endDate"] ?? "");
                      // print(dates);
                      setState(() {});
                      // print(">>>>>>>>>");
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      width: 28.w,
                    ),
                  ),
                ),
                // SizedBox(width: 16.w),
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: () async {
                    final data =
                        await customBottomSheet(context, filterWidget(check1));
                    // print(data);
                    if (data != null) {
                      check1 = data;
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.0.w),
                    child: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      width: 28.w,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              width: 1.sw,
              height: 1.sh,
              child:
               RefreshIndicator(
                  displacement: 60.h,
                  backgroundColor: AppConstant.primaryColor,
                  color: Colors.white,
                  strokeWidth: 2.h,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: () async {
                   
                    check1 = [true, true, true];
                    hasCalendar = false;
                    startTime = null;
                    endTime = null;
                    setState(() {});
                    await AppController.refresh(
                      context,
                    );
                  },
                  child: Container(
                      width: 1.sw,
                      height: 1.sh,
                      child: apps == null
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: const Color(0xffBE52F2),
                                    strokeWidth: 6.w,
                                    strokeAlign: 2,
                                    strokeCap: StrokeCap.round,
                                    backgroundColor: const Color(0xffBE52F2)
                                        .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    height: 48.h,
                                  ),
                                  SizedBox(
                                    width: 365.w,
                                    child: Text(
                                      "Загрузка информации...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : apps.isEmpty
                              ? Center(
                                  child: SizedBox(
                                    height: 200.h,
                                    child: Text(
                                      "Нет данных",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                )
                              : AnimationLimiter(
                                child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics(),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                      top: 12.h,
                                      bottom: 32.h,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        universalList(apps).length,
                                        (j) => AnimationConfiguration.staggeredList(
                                          position: j,
                                          delay: Duration(milliseconds: 200),
                                          child: SlideAnimation(
                                            duration: Duration(milliseconds: 3500),
                                            curve: Curves.fastLinearToSlowEaseIn,
                                            child: FadeInAnimation(
                                              duration: Duration(milliseconds: 3500),
                                              curve: Curves.fastLinearToSlowEaseIn,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      // horizontal: 16.w,
                                                      vertical: 8.h,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        // SizedBox(height: 24.h),
                                                        Text(
                                                          DateTime.parse((universalList(
                                                                          apps)[j][0][
                                                                      "created_time"] ??
                                                                  universalList(apps)[j]
                                                                          [0]
                                                                      ["finished_time"]))
                                                              .textInString
                                                              .capitalize(),
                                                          style: TextStyle(
                                                            color:
                                                                const Color(0xFF242424),
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 8.h),
                                                    child: Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      // decoration: BoxDecoration(
                                                      //   color: Colors.white,
                                                      //   borderRadius: BorderRadius.circular(6.r),
                                                      //   border: Border.all(
                                                      //     width: 1.sp,
                                                      //     color: const Color(0xffE8E8E8),
                                                      //   ),
                                                      // ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: 16.w,
                                                          vertical: 8.h,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Column(
                                                              children: List.generate(
                                                                universalList(apps)[j]
                                                                    .length,
                                                                (index) => Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize.min,
                                                                  children: [
                                                                    CustomTile(
                                                                      app:
                                                                          universalList(
                                                                                  apps)[
                                                                              j][index],
                                                                      avatar:
                                                                          "assets/icons/person.svg",
                                                                    ),
                                                                    Divider(
                                                                      color: Color(
                                                                              0xFFE4E4E4)
                                                                          .withOpacity(
                                                                              0.5),
                                                                      thickness: 1,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ))),
            ),
          ),
        );
      },
    );
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.day == date2.day &&
      date1.month == date2.month &&
      date1.year == date2.year;
}

List universalList(List? my_apps) {
  if (my_apps == null) {
    return <List>[];
  } else if (my_apps.isEmpty) {
    return <List>[];
  }
  List<List> result = [
    [my_apps[0]]
  ];
  for (var i = 0; i < my_apps.length - 1; i++) {
    my_apps[i]["created_time"] ??= my_apps[i]["finished_time"];
    my_apps[i + 1]["created_time"] ??= my_apps[i + 1]["finished_time"];

    if (my_apps[i]["created_time"] != null &&
        my_apps[i + 1]["created_time"] != null) {
      if (isSameDay(DateTime.parse(my_apps[i]["created_time"]),
          DateTime.parse(my_apps[i + 1]["created_time"]))) {
        result.last.add(my_apps[i + 1]);
      } else {
        result.add([my_apps[i + 1]]);
      }
    }
  }
  return result;
}
