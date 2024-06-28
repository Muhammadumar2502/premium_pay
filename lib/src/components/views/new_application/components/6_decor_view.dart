import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class DecorView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  double? total;
  DecorView(
      {Key? key, required this.appModel, this.isAvailable = true, this.total})
      : super(key: key);

  @override
  State<DecorView> createState() => _DecorViewState();
}

class _DecorViewState extends State<DecorView> {
  ExpansionTileController? controller = ExpansionTileController();
  int selectedPeriod = -1;

  double totalPrice() {
    // double price = 0;
    // for (int i = 0; i < widget.products.length; i++) {
    //   price += (double.tryParse(widget.products[i]['price'].toString().replaceAll(' ', '')) ?? 0);
    // }
    return double.tryParse(widget.appModel["amount"].toString()) ?? 0;
  }

  double getAvg() {
    return (double.tryParse(widget.appModel["limit_summa"].toString()) ?? 0) /
        12;
  }

  // checkPeriod(int period) {
  //   return getAvg() * period >= totalPrice();
  // }
  checkPeriod(int period,List months) {
     final monthsValue = [12,9,6,3];
     int index = monthsValue.indexOf(period);
     print(index);
    // print(months);
    // print(period);
    // print(monthsValue.firstWhere((e)=>e==period));
    return getAvg() * period >= (totalPrice() ?? 0) *months[index] ;
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController productController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<String> types = [
    'Сумма покупки:',
    'Сумма с рассрочкой:',
    'Ежемесячный платеж:',
  ];
  List<String> customer_rejection = [
    "Клиент ушел с магазина",
    "Не хватало по лимита",
    "Клиент отказался",
    "Другой",

    // 'Слишком долго ждал',
    // 'Высокий процент',
    // 'Неподходящий срок'
  ];
  // List<String> costs = [
  //   '3,000,000 сум',
  //   '7,000,000 сум',
  //   '583.333.00 сум',
  // ];
  TextEditingController fullPriceController = TextEditingController();
  int radioListValue = 0;

  List<String> rejections = ['Передумал', 'Высокий процент'];
  String? canceled_reason;
  // ExpansionTileController? controller = ExpansionTileController();

  @override
  void initState() {
    PercentsController.get(context);
    super.initState();
  }

  // int selectedIndex = 0;
  LoadingService loadingService = LoadingService();
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
            "Оформление",
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
          //   actions: [
          //     GestureDetector(
          //       onTap: () {},
          //       child: Padding(
          //         padding: EdgeInsets.all(6.w),
          //         child: SvgPicture.asset(
          //           'assets/icons/upload.svg',
          //           width: 22.w,
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {},
          //       child: Padding(
          //         padding: EdgeInsets.all(6.w),
          //         child: SvgPicture.asset(
          //           'assets/icons/download.svg',
          //           width: 28.w,
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 10.w,
          //     )
          //   ],
        ),
        body:
        
         BlocBuilder<GetPercentsBloc, GetPercentsState>(
            builder: (context, state) {
          if (state is GetPercentsWaitingState) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: const Color(0xffBE52F2),
                  strokeWidth: 6.w,
                  strokeAlign: 2,
                  strokeCap: StrokeCap.round,
                  backgroundColor: const Color(0xffBE52F2).withOpacity(0.2),
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
            ));
          } else if (state is GetPercentsSuccessState) {
            print(state.data);
            final data = (state.data as List);
            data.sort((a, b) => ((int.tryParse(a["month"].toString()) ?? 0) <
                    (int.tryParse(b["month"].toString()) ?? 0))
                ? 1
                : -1);
            print(">> " + data.toString());
            final monthData = data
                .map((e) =>
                    (((double.tryParse(e["percent"].toString()) ?? 0) + 100) /
                        100))
                .toList();
            print(monthData);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Color(0xFFBE52F2),
                      shadowColor: const Color(0xff323247).withOpacity(0.3),
                      fixedSize: Size(327.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, RouteNames.productsView,
                          arguments: {
                            "appModel": widget.appModel,
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 275.w,
                          alignment: Alignment.center,
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Изменить товары ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 24.r,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    width: 325.w,
                    margin:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff323247).withOpacity(0.2),
                          offset: Offset(0, 4.h),
                          blurRadius: 8.r,
                        )
                      ],
                    ),
                    child: ExpansionTile(
                      controller: controller,
                      // tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
                      // collapsedBackgroundColor:Color(0xffBE52F2) ,
                      // collapsedTextColor: ,
                      // backgroundColor: Color(0xffBE52F2) ,
                      // collapsedIconColor: Color(0xffBE52F2),
                      // title: Text(items[index]["checked"] ?  (items[index]["children"] as List).map((e) => e["controller"].text.toString()).toList().join(" "): items[index]["title"]),
                      onExpansionChanged: (value) {
                        setState(() {
                          // items[index]["textColor"] =
                          //     !value ? Color(0xff242424) : Colors.white;
                        });
                      },
      
                      title: Text(
                        selectedPeriod == -1
                            ? "Выберите период"
                            : "${[12, 9, 6, 3][selectedPeriod]} месяцев",
                        style: TextStyle(
                            color: Color(0xff242424),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300),
                      ),
      
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      children: List.generate(
                        4,
                        (i) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              thickness: 0.5.h,
                              height: 0.5.h,
                              color: Color(0XFF151522).withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {
                                if (checkPeriod([12, 9, 6, 3][i],monthData)) {
                                  selectedPeriod = i;
                                  setState(() {});
                                  controller?.collapse();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      [
                                        "12 месяцев",
                                        "9 месяцев",
                                        "6 месяцев",
                                        "3 месяцев",
                                      ][i],
                                      style: TextStyle(
                                          color: Color(0xff242424),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    checkPeriod([12, 9, 6, 3][i],monthData)
                                        ? Transform.scale(
                                            scale: 1.4,
                                            child: SvgPicture.asset(
                                              "assets/icons/check.svg",
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Transform.scale(
                                            scale: 1.4,
                                            child: SvgPicture.asset(
                                              "assets/icons/cancel.svg",
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    width: 325.w,
                    // height: 150.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
      
                       
                         Text(
                          "Деталь для выбранного периода",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
      
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                    color: Color(0xFFE4E4E4).withOpacity(0.6),
                    thickness: 1,
                  ),
                   SizedBox(
                          height: 10.h,
                        ),
                          Container(
                    width: 325.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Сумма покупки :",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "${toMoney(totalPrice())} сум",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    width: 325.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Сумма с рассрочкой :",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          selectedPeriod == -1
                              ? "- - -"
                              : "${toMoney((monthData[selectedPeriod] * totalPrice()))} сум",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    width: 325.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ежемесячный платеж :",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          selectedPeriod == -1
                              ? "- - -"
                              : "${toMoney(monthData[selectedPeriod] * totalPrice() / [
                                    12,
                                    9,
                                    6,
                                    3
                                  ][selectedPeriod])} сум",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
               
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r,),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff32324714),
                          spreadRadius: 0,
                          blurRadius: 16.r,
                          offset: Offset(0, 12.h),
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff14E5A9),
                        Color(0xff00C48C),
                        
                      ])
                    ),
                  ),
                 
                  // Divider(
                  //   color: Color(0xFFE4E4E4).withOpacity(0.6),
                  //   thickness: 1,
                  // ),
                  // Container(
                  //   width: 325.w,
                  //   height: 40.h,
                  //   alignment: Alignment.center,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Сумма покупки",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 13.sp,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       Text(
                  //         "${toMoney(totalPrice())}сум",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 13.sp,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Divider(
                  //   color: Color(0xFFE4E4E4).withOpacity(0.6),
                  //   thickness: 1,
                  // ),
                  // Container(
                  //   width: 325.w,
                  //   height: 40.h,
                  //   alignment: Alignment.center,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Сумма с рассрочкой",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 13.sp,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       Text(
                  //         selectedPeriod == -1
                  //             ? "- - -"
                  //             : "${toMoney((monthData[selectedPeriod] * totalPrice()))} сум",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 13.sp,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Divider(
                  //   color: Color(0xFFE4E4E4).withOpacity(0.6),
                  //   thickness: 1,
                  // ),
                  // Container(
                  //   width: 325.w,
                  //   height: 40.h,
                  //   alignment: Alignment.center,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Ежемесячный платеж",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 13.sp,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       Text(
                  //         selectedPeriod == -1
                  //             ? "- - -"
                  //             : "${toMoney(monthData[selectedPeriod] * totalPrice() / [
                  //                   12,
                  //                   9,
                  //                   6,
                  //                   3
                  //                 ][selectedPeriod])} сум",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 13.sp,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Divider(
                  //   color: Color(0xFFE4E4E4).withOpacity(0.6),
                  //   thickness: 1,
                  // ),
      
      
      
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    width: 325.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 325.w,
                          child: Text(
                            "Расчёты произведены на основе данных представленных клиентом и могут отличаться от произведённых в банке ",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w200,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor:selectedPeriod > -1 ?  const Color(0xffBE52F2) :Colors.grey.shade300,
                      shadowColor:selectedPeriod > -1 ? const Color(0xff323247).withOpacity(0.3) :Colors.transparent,
                      fixedSize: Size(327.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      // print(selectedIndex);
                      print(selectedPeriod);
                      if (selectedPeriod > -1) {
                        ZayavkaController.update6(context,
                            id: "${widget.appModel["id"]}",
                            expired_month:
                                state.data[selectedPeriod]["month"].toString(),
                            payment_amount: ((((widget.appModel["amount"] ??
                                        widget.total) ??
                                    0) *
                                monthData[selectedPeriod])));
                      }
                    },
                    child: Text(
                      "Оформить",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor:  Color(0xffFF647C),
                      // shadowColor:  Colors.transparent,
                      fixedSize: Size(327.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () async {
                      final data = await customBottomSheet(
                          context, decorWidget(customer_rejection, -1));
                      print(data);
                      if (data != null) {
                        String canceled_reason = customer_rejection[data];
                        ZayavkaController.cancelByClient(context,
                            id: "${widget.appModel["id"]}",
                            canceled_reason: canceled_reason);
                      }
                    },
                    child: Text(
                      "Отказ заявка",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  BlocListener<UpdateApp6Bloc, UpdateApp6State>(
                      child: SizedBox(),
                      listener: (context, state) async {
                        if (state is UpdateApp6WaitingState) {
                          loadingService.showLoading(context);
                        } else if (state is UpdateApp6ErrorState) {
                          loadingService.closeLoading(context);
                          if (state.statusCode == 401) {
                            Future.wait([
                              CacheService.remove(
                                CacheService.token,
                              ),
                              CacheService.remove(
                                CacheService.user,
                              )
                            ]);
                            Flushbar(
                              backgroundColor: Colors.red.shade700,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
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
      
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.login,
                              (route) => false,
                            );
                          } else {
                            Flushbar(
                              backgroundColor: Colors.red.shade700,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              isDismissible: true,
                              message: state.message,
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
                        } else if (state is UpdateApp6SuccessState) {
                          loadingService.closeLoading(context);
                          widget.appModel = state.data;
                          AppController.update6(
                            context,
                            id: widget.appModel["id"].toString(),
                            app: widget.appModel,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.SelfieWithCheckView,
                            arguments: {
                              "appModel": widget.appModel,
                            },
                          );
                        }
                      }),
                  BlocListener<CancelByClientBloc, CancelByClientState>(
                      child: SizedBox(),
                      listener: (context, state) async {
                        if (state is CancelByClientWaitingState) {
                          loadingService.showLoading(context);
                        } else if (state is CancelByClientErrorState) {
                          loadingService.closeLoading(context);
                          if (state.statusCode == 401) {
                            Future.wait([
                              CacheService.remove(
                                CacheService.token,
                              ),
                              CacheService.remove(
                                CacheService.user,
                              )
                            ]);
                            Flushbar(
                              backgroundColor: Colors.red.shade700,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
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
      
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.login,
                              (route) => false,
                            );
                          } else {
                            Flushbar(
                              backgroundColor: Colors.red.shade700,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              isDismissible: true,
                              message: state.message,
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
                        } else if (state is CancelByClientSuccessState) {
                          loadingService.closeLoading(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, RouteNames.applicationView, (r) => true);
                          Flushbar(
                            backgroundColor: Colors.green.shade500,
                            dismissDirection:
                                FlushbarDismissDirection.HORIZONTAL,
                            flushbarPosition: FlushbarPosition.TOP,
                            flushbarStyle: FlushbarStyle.GROUNDED,
                            isDismissible: true,
                            message: "Заявка успешно удалено",
                            messageColor: Colors.white,
                            messageSize: 18.sp,
                            icon: Icon(
                              Icons.check,
                              size: 28.0,
                              color: Colors.white,
                            ),
                            duration: Duration(minutes:1),
                            leftBarIndicatorColor: Colors.white,
                          ).show(context);
                        }
                      }),
                ],
              ),
            );
      
            // return SingleChildScrollView(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         height: 24.h,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Container(
            //             height: 89.h,
            //             width: 325.w,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Общая сумма товара",
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 15.sp,
            //                     fontWeight: FontWeight.w400,
            //                   ),
            //                 ),
            //                 Container(
            //                   width: 325.w,
            //                   alignment: Alignment.centerLeft,
            //                   padding: EdgeInsets.symmetric(horizontal: 15.w),
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(5.r),
            //                     border: Border.all(
            //                       width: 1.w,
            //                       color: Color(0xffE4E4E4),
            //                     ),
            //                   ),
            //                   child: TextField(
            //                     readOnly: true,
            //                     style: TextStyle(
            //                         fontSize: 15.sp,
            //                         color: Colors.black,
            //                         fontWeight: FontWeight.w500,
            //                         height: 1),
            //                     decoration: InputDecoration(
            //                       contentPadding: EdgeInsets.symmetric(
            //                           horizontal: 10.w, vertical: 15.h),
            //                       // isDense: true,
            //                       border: const OutlineInputBorder(
            //                           borderSide: BorderSide.none),
            //                       hintStyle: TextStyle(
            //                         fontSize: 15.sp,
            //                         fontWeight: FontWeight.w500,
            //                         color: widget.appModel["amount"] == null
            //                             ? Color(0xffC0C0C0)
            //                             : Colors.black,
            //                       ),
            //                       hintText: widget.appModel["amount"] == null
            //                           ? null
            //                           : toMoney(widget.appModel["amount"]) +
            //                               " сум",
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 24.h,
            //       ),
            //       SizedBox(
            //         width: 325.w,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Выберите один из периодов рассрочки",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 15.sp,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 16.h,
            //       ),
            //       Container(
            //         margin:
            //             EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.r),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: const Color(0xff323247).withOpacity(0.14),
            //                   offset: Offset(0, 4.h),
            //                   blurRadius: 8.r)
            //             ]),
            //         child: ExpansionTile(
            //           controller: controller,
            //           tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
            //           // collapsedBackgroundColor:Color(0xffBE52F2) ,
            //           // collapsedTextColor: ,
            //           // backgroundColor: Color(0xffBE52F2) ,
            //           // collapsedIconColor: Color(0xffBE52F2),
            //           // title: Text(items[index]["checked"] ?  (items[index]["children"] as List).map((e) => e["controller"].text.toString()).toList().join(" "): items[index]["title"]),
            //           onExpansionChanged: (value) {
            //             // setState(() {
            //             // items[index]["textColor"] =
            //             //     !value ? Color(0xff242424) : Colors.white;
            //             // });
            //           },
      
            //           title: Text(
            //             (state.data as List)
            //                     .map((e) => e["month"])
            //                     .toList()[selectedIndex]
            //                     .toString() +
            //                 " месяцев",
            //             style: TextStyle(
            //               color: Color(0xff242424),
            //               fontSize: 14.sp,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
      
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8.r),
            //           ),
            //           children: List.generate(
            //             1,
            //             // (state.data as List)
            //             //     .map((e) => e["month"])
            //             //     .toList()
            //             //     .length,
            //             (i) => Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Divider(
            //                   thickness: 0.5.h,
            //                   height: 0.5.h,
            //                   color: Color(0XFF151522).withOpacity(0.1),
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     if (isAvailableMonth(
            //                         widget.appModel,
            //                         (state.data as List)
            //                             .map((e) => e["month"].toString())
            //                             .toList()[i])) {
            //                       selectedIndex = i;
            //                       controller?.collapse();
            //                       setState(() {});
            //                     }
            //                   },
            //                   child: Padding(
            //                       padding: EdgeInsets.symmetric(
            //                           horizontal: 24.w, vertical: 10.h),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text(
            //                             (state.data as List)
            //                                     .map((e) =>
            //                                         e["month"].toString())
            //                                     .toList()[i] +
            //                                 " месяцев",
            //                             style: TextStyle(
            //                                 color: Color(0xff242424),
            //                                 fontSize: 14.sp,
            //                                 fontWeight: FontWeight.w300),
            //                           ),
            //                           Transform.scale(
            //                             scale: 1.4,
            //                             child: SvgPicture.asset(
            //                                 "assets/icons/" +
            //                                     (isAvailableMonth(
            //                                             widget.appModel,
            //                                             (state.data as List)
            //                                                 .map((e) =>
            //                                                     e["month"]
            //                                                         .toString())
            //                                                 .toList()[i])
            //                                         ? "check.svg"
            //                                         : "cancel.svg"),
            //                                 fit: BoxFit.cover),
            //                           )
            //                         ],
            //                       )),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 24.h,
            //       ),
            //       SizedBox(
            //         width: 325.w,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Оформление рассрочки",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 15.sp,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 16.h,
            //       ),
            //       Container(
            //         width: 325.w,
            //         // xasg
            //         padding:
            //             EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.r),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: const Color(0xff323247).withOpacity(0.14),
            //                   offset: Offset(0, 4.h),
            //                   blurRadius: 8.r)
            //             ]),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Container(
            //               width: 325.w,
            //               height: 40.h,
            //               alignment: Alignment.center,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     "Общая сумма рассрочки :",
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                   Text(
            //                     toMoney(((((widget.total ??
            //                                         widget
            //                                             .appModel["amount"]) ??
            //                                     0) *
            //                                 (1 +
            //                                     (int.parse(state
            //                                             .data[selectedIndex]
            //                                                 ["percent"]
            //                                             .toString()) /
            //                                         100))) as double)
            //                             .toInt()) +
            //                         " сум",
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               width: 325.w,
            //               height: 40.h,
            //               alignment: Alignment.center,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     "Ежемесячная оплата : ",
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                   Text(
            //                     "${((((widget.total ?? widget.appModel["amount"]) ?? 0) * (1 + (int.parse(state.data[selectedIndex]["percent"].toString()) / 100))) as double).toInt() ~/ int.parse(state.data[selectedIndex]["month"].toString())} сум",
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 24.h,
            //       ),
            //       SizedBox(
            //         height: 24.h,
            //       ),
            //       SizedBox(
            //         width: 325.w,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             SizedBox(
            //               width: 325.w,
            //               child: Text(
            //                 "Расчёты произведены на основе данных представленных клиентом и могут отличаться от произведённых в банке ",
            //                 style: TextStyle(
            //                   color: Colors.grey.shade600,
            //                   fontSize: 15.sp,
            //                   fontWeight: FontWeight.w200,
            //                 ),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 24.h,
            //       ),
            //       BlocListener<UpdateApp6Bloc, UpdateApp6State>(
            //           child: SizedBox(),
            //           listener: (context, state) async {
            //             if (state is UpdateApp6WaitingState) {
            //               loadingService.showLoading(context);
            //             } else if (state is UpdateApp6ErrorState) {
            //               loadingService.closeLoading(context);
            //               if (state.statusCode == 401) {
            //                 Future.wait([
            //                   CacheService.remove(
            //                     CacheService.token,
            //                   ),
            //                   CacheService.remove(
            //                     CacheService.user,
            //                   )
            //                 ]);
            //                 Flushbar(
            //                   backgroundColor: Colors.red.shade700,
            //                   dismissDirection:
            //                       FlushbarDismissDirection.HORIZONTAL,
            //                   flushbarPosition: FlushbarPosition.TOP,
            //                   flushbarStyle: FlushbarStyle.GROUNDED,
            //                   isDismissible: true,
            //                   message: "Пожалуйста, войдите снова",
            //                   messageColor: Colors.white,
            //                   messageSize: 18.sp,
            //                   icon: Icon(
            //                     Icons.error,
            //                     size: 28.0,
            //                     color: Colors.white,
            //                   ),
            //                   duration: Duration(minutes:1),
            //                   leftBarIndicatorColor: Colors.red.shade700,
            //                 ).show(context);
      
            //                 Navigator.pushNamedAndRemoveUntil(
            //                   context,
            //                   RouteNames.login,
            //                   (route) => false,
            //                 );
            //               } else {
            //                 Flushbar(
            //                   backgroundColor: Colors.red.shade700,
            //                   dismissDirection:
            //                       FlushbarDismissDirection.HORIZONTAL,
            //                   flushbarPosition: FlushbarPosition.TOP,
            //                   flushbarStyle: FlushbarStyle.GROUNDED,
            //                   isDismissible: true,
            //                   message: state.message,
            //                   messageColor: Colors.white,
            //                   messageSize: 18.sp,
            //                   icon: Icon(
            //                     Icons.error,
            //                     size: 28.0,
            //                     color: Colors.white,
            //                   ),
            //                   duration: Duration(minutes:1),
            //                   leftBarIndicatorColor: Colors.red.shade700,
            //                 ).show(context);
            //               }
            //             } else if (state is UpdateApp6SuccessState) {
            //               loadingService.closeLoading(context);
            //               widget.appModel = state.data;
            //               AppController.update6(
            //                 context,
            //                 id: widget.appModel["id"].toString(),
            //                 app: widget.appModel,
            //               );
            //               Navigator.pushReplacementNamed(
            //                 context,
            //                 RouteNames.contractView,
            //                 arguments: {
            //                   "appModel": widget.appModel,
            //                 },
            //               );
            //             }
            //           }),
            //       BlocListener<CancelByClientBloc, CancelByClientState>(
            //           child: SizedBox(),
            //           listener: (context, state) async {
            //             if (state is CancelByClientWaitingState) {
            //               loadingService.showLoading(context);
            //             } else if (state is CancelByClientErrorState) {
            //               loadingService.closeLoading(context);
            //               if (state.statusCode == 401) {
            //                 Future.wait([
            //                   CacheService.remove(
            //                     CacheService.token,
            //                   ),
            //                   CacheService.remove(
            //                     CacheService.user,
            //                   )
            //                 ]);
            //                 Flushbar(
            //                   backgroundColor: Colors.red.shade700,
            //                   dismissDirection:
            //                       FlushbarDismissDirection.HORIZONTAL,
            //                   flushbarPosition: FlushbarPosition.TOP,
            //                   flushbarStyle: FlushbarStyle.GROUNDED,
            //                   isDismissible: true,
            //                   message: "Пожалуйста, войдите снова",
            //                   messageColor: Colors.white,
            //                   messageSize: 18.sp,
            //                   icon: Icon(
            //                     Icons.error,
            //                     size: 28.0,
            //                     color: Colors.white,
            //                   ),
            //                   duration: Duration(minutes:1),
            //                   leftBarIndicatorColor: Colors.red.shade700,
            //                 ).show(context);
      
            //                 Navigator.pushNamedAndRemoveUntil(
            //                   context,
            //                   RouteNames.login,
            //                   (route) => false,
            //                 );
            //               } else {
            //                 Flushbar(
            //                   backgroundColor: Colors.red.shade700,
            //                   dismissDirection:
            //                       FlushbarDismissDirection.HORIZONTAL,
            //                   flushbarPosition: FlushbarPosition.TOP,
            //                   flushbarStyle: FlushbarStyle.GROUNDED,
            //                   isDismissible: true,
            //                   message: state.message,
            //                   messageColor: Colors.white,
            //                   messageSize: 18.sp,
            //                   icon: Icon(
            //                     Icons.error,
            //                     size: 28.0,
            //                     color: Colors.white,
            //                   ),
            //                   duration: Duration(minutes:1),
            //                   leftBarIndicatorColor: Colors.red.shade700,
            //                 ).show(context);
            //               }
            //             } else if (state is CancelByClientSuccessState) {
            //               loadingService.closeLoading(context);
            //               Navigator.pushNamedAndRemoveUntil(
            //                   context, RouteNames.applicationView, (r) => true);
            //               Flushbar(
            //                 backgroundColor: Colors.green.shade500,
            //                 dismissDirection:
            //                     FlushbarDismissDirection.HORIZONTAL,
            //                 flushbarPosition: FlushbarPosition.TOP,
            //                 flushbarStyle: FlushbarStyle.GROUNDED,
            //                 isDismissible: true,
            //                 message: "Заявка успешно удалено",
            //                 messageColor: Colors.white,
            //                 messageSize: 18.sp,
            //                 icon: Icon(
            //                   Icons.check,
            //                   size: 28.0,
            //                   color: Colors.white,
            //                 ),
            //                 duration: Duration(minutes:1),
            //                 leftBarIndicatorColor: Colors.white,
            //               ).show(context);
            //             }
            //           }),
      
            //       GestureDetector(
            //         onTap: () {
            //           // ignore: unnecessary_type_check
            //           if (state is GetPercentsSuccessState) {
            //             ZayavkaController.update6(context,
            //                 id: "${widget.appModel["id"]}",
            //                 expired_month:
            //                     state.data[selectedIndex]["month"].toString(),
            //                 payment_amount: ((((widget.appModel["amount"] ??
            //                                 widget.total) ??
            //                             0) *
            //                         (1 +
            //                             (int.parse(state.data[selectedIndex]
            //                                         ["percent"]
            //                                     .toString()) /
            //                                 100))) as double)
            //                     .toInt());
            //           }
            //         },
            //         child: Container(
            //           width: 327.w,
            //           height: 50.h,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               color: const Color(0xffBE52F2),
            //               borderRadius: BorderRadius.circular(8.r),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: const Color(0xff323247).withOpacity(0.3),
            //                   offset: Offset(0, 4.h),
            //                   blurRadius: 4.r,
            //                   // blurStyle: BlurStyle.outer
            //                 ),
            //               ]),
            //           child: Text(
            //             "Оформить",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 16.sp,
            //               fontWeight: FontWeight.w300,
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 16.h,
            //       ),
            //       Container(
            //         width: 327.w,
            //         height: 50.h,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade400,
            //           borderRadius: BorderRadius.circular(8.r),
            //         ),
            //         child: Text(
            //           "Отказ клиента",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16.sp,
            //             fontWeight: FontWeight.w300,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
          } else {
            return SizedBox();
          }
        }),
          
      ),
    );
  }

  isAvailableMonth(Map appModel, String? month) {
    return true;
  }

  scoringWidget<Widget>() {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 350.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Container(
                  width: 60.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                Column(
                  children: List.generate(
                    4,
                    (index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: index == 5
                              ? const Border()
                              : Border(
                                  bottom: BorderSide(
                                    width: 0.1.sp,
                                  ),
                                ),
                        ),
                        child: RadioListTile(
                          title: Text(
                            rejections[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: index,
                          onChanged: (value) {
                            setState(() {
                              radioListValue = value!;
                            });
                          },
                          groupValue: radioListValue,
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                customButton(
                  context,
                  'Применить',
                  () {
                    Navigator.of(context).pop();
                  },
                  Colors.deepPurple,
                ),
                SizedBox(height: 16.sp),
              ],
            ),
          ),
        );
      },
    );
  }

//   confirmationWidget<Widget>() {
//     return SizedBox(
//       height: 200.h,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.sp),
//         child: Column(
//           children: [
//             SizedBox(height: 16.h),
//             Container(
//               width: 60.w,
//               height: 3.h,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(3.r),
//               ),
//             ),
//             SizedBox(height: 16.h),
//             Align(
//               alignment: Alignment(-0.8.w, 0),
//               child: Text(
//                 'Тип загрузки изображения',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Column(
//               children: List.generate(
//                 2,
//                 (index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       border: index == 1
//                           ? const Border()
//                           : Border(
//                               bottom: BorderSide(
//                                 width: 0.1.sp,
//                               ),
//                             ),
//                     ),
//                     child: ListTile(
//                       onTap: () {
//                         if (index == 0) {
//                           pickImage(ImageSource.gallery);
//                         } else if (index == 1) {
//                           pickImage(ImageSource.camera);
//                         }
//                       },
//                       title: Text(
//                         titles[index],
//                         style: TextStyle(
//                           color: Colors.grey.shade400,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       trailing: Image.asset(logos[index], scale: 3),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16.sp),
//           ],
//         ),
//       ),
//     );
//   }
// }

  // fullProductPriceArea<Widget>(
  //   GetPercentsState state,
  // ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Общая сумма товара',
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       SizedBox(height: 8.h),
  //       Container(
  //         width: MediaQuery.of(context).size.width,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(6.r),
  //           border: Border.all(
  //             width: 1.sp,
  //             color: const Color(0xffE8E8E8),
  //           ),
  //         ),
  //         padding: EdgeInsets.all(16.w),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Общая сумма товара',
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 12.sp,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             SizedBox(height: 5.h),
  //             Container(
  //               alignment: Alignment.centerLeft,
  //               padding: EdgeInsets.symmetric(horizontal: 16.w),
  //               height: 50.h,
  //               width: MediaQuery.of(context).size.width,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(6.r),
  //                 border: Border.all(
  //                   width: 1.sp,
  //                   color: const Color(0xffE8E8E8),
  //                 ),
  //               ),
  //               child: TextFormField(
  //                 controller: fullPriceController,
  //                 readOnly: true,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16.sp,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //                 decoration: InputDecoration(
  //                   border: InputBorder.none,
  //                   hintText:
  //                       toMoney(widget.total ?? widget.appModel["amount"]) +
  //                           " сум",
  //                   hintStyle: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             if (state is GetPercentsSuccessState)
  //               Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: 16.h),
  //                   Text(
  //                     'Выберите срок',
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 12.sp,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5.h),
  //                   GestureDetector(
  //                     onTap: () async {
  //                       s = (await customBottomSheet(
  //                               context,
  //                               decorWidget(
  //                                   (state.data as List)
  //                                       .map((e) => " ${e["month"]}  месяцев")
  //                                       .toList(),
  //                                   selectedIndex))) ??
  //                           selectedIndex;

  //                       print(selectedIndex);
  //                       setState(() {});
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.centerLeft,
  //                       padding: EdgeInsets.symmetric(horizontal: 16.w),
  //                       height: 50.h,
  //                       width: MediaQuery.of(context).size.width,
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(6.r),
  //                         border: Border.all(
  //                           width: 1.sp,
  //                           color: const Color(0xffE8E8E8),
  //                         ),
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             " ${state.data[selectedIndex]["month"]}  месяцев -  ${state.data[selectedIndex]["percent"]} %",
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 16.sp,
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           ),
  //                           Icon(
  //                             CupertinoIcons.chevron_down,
  //                             color: Colors.grey.shade400,
  //                             size: 16.sp,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),

  //             SizedBox(height: 16.h),
  //             // Text(
  //             //   'Условия рассрочки:',
  //             //   style: TextStyle(
  //             //     color: Colors.black,
  //             //     fontSize: 12.sp,
  //             //     fontWeight: FontWeight.w400,
  //             //   ),
  //             // ),
  //             // SizedBox(height: 5.h),
  //             // GestureDetector(
  //             //   onTap: () {
  //             //     customBottomSheet(context, decorWidget());
  //             //   },
  //             //   child: Container(
  //             //     alignment: Alignment.centerLeft,
  //             //     padding: EdgeInsets.symmetric(horizontal: 16.w),
  //             //     height: 50.h,
  //             //     width: MediaQuery.of(context).size.width,
  //             //     decoration: BoxDecoration(
  //             //       color: Colors.white,
  //             //       borderRadius: BorderRadius.circular(6.r),
  //             //       border: Border.all(
  //             //         width: 1.sp,
  //             //         color: const Color(0xffE8E8E8),
  //             //       ),
  //             //     ),
  //             //     child: Row(
  //             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             //       children: [
  //             //         Text(
  //             //           'Условия рассрочки:',
  //             //           style: TextStyle(
  //             //             color: Colors.grey.shade400,
  //             //             fontSize: 16.sp,
  //             //             fontWeight: FontWeight.w400,
  //             //           ),
  //             //         ),
  //             //         Icon(
  //             //           CupertinoIcons.chevron_down,
  //             //           color: Colors.grey.shade400,
  //             //           size: 16.sp,
  //             //         )
  //             //       ],
  //             //     ),
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  String filePath =
      "http://premiumpayapi.uz/static/pdfs/21321320002023-07-21T18:07:00.083Z.pdf";
  shareit() async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      // Here just ask for the permission for the first time
      await Permission.storage.request();

      // I noticed that sometimes popup won't show after user press deny
      // so I do the check once again but now go straight to appSettings
      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Here open app settings for user to manually enable permission in case
      // where permission was permanently denied
      await openAppSettings();
    } else {
      var response = await Dio()
          .get(filePath, options: Options(responseType: ResponseType.bytes));
      final directory = await getApplicationDocumentsDirectory();
      String savedPath = directory.path +
          "/premium-pay/" +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ".pdf";
      File file = await File(savedPath).create(recursive: true);
      await file.writeAsBytes(response.data);
      // ignore: deprecated_member_use
      Share.shareFiles(
        [savedPath],
      );
      // Do stuff that require permission here
    }
  }

  // ignore: unused_element
  _saveNetworkDoc() async {
    var response = await Dio()
        .get(filePath, options: Options(responseType: ResponseType.bytes));
    //  final directory = await getDownloadsDirectory();
    final directory = "/storage/emulated/0/Download/";
    String savedPath = directory +
        "/premium-pay/" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".pdf";

    File file = await File(savedPath).create(recursive: true);
    await file.writeAsBytes(response.data);

    Flushbar(
      backgroundColor: Colors.green.shade700,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      message: "Hujjat Saqlandi",
      messageColor: Colors.white,
      messageSize: 18.sp,
      icon: Icon(
        CupertinoIcons.check_mark,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.green.shade700,
    ).show(context);

    // print(result);
  }

  decorWidget(List data, int selectedIndex) {
    int selectedI = selectedIndex;
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 350.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        data.length,
                        (index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: index == 5
                                  ? const Border()
                                  : Border(
                                      bottom: BorderSide(
                                        width: 0.1.sp,
                                      ),
                                    ),
                            ),
                            child: RadioListTile(
                              title: Text(
                                data[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: index,
                              onChanged: (value) {
                                setState(() {
                                  selectedI = value!;
                                });
                              },
                              groupValue: selectedI,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                customButton(context, 'Применить', () {
                  if (selectedI > 0) {
                    Navigator.of(context).pop(selectedI);
                  }
                },
                 selectedI < 0 ? Colors.grey.shade200 :    AppConstant.primaryColor
                        ,
                    buttonWidth: 325.w),
                SizedBox(height: 16.sp),
              ],
            ),
          ),
        );
      },
    );
  }
}
