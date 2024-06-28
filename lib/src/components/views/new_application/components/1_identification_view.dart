// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class IdentificationView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  IdentificationView(
      {Key? key, required this.appModel, this.isAvailable = true})
      : super(key: key);

  @override
  State<IdentificationView> createState() => _IdentificationViewState();
}

class _IdentificationViewState extends State<IdentificationView> {
  final formKey = GlobalKey<FormState>();

  var passportFormat = MaskTextInputFormatter(
    mask: 'SS #######',
    filter: {"S": RegExp('[AA,AB,AC,AD,AE]'), "#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var dateMaskformat = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {"S": RegExp('##.##.####'), "#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  DateTime selectedDate = DateTime.now();
  Color selectedColor = Colors.grey.shade400;
  LoadingService loadingService = LoadingService();
  Map? myidInfo;
  String? myidImageInBase64;

  String? gender;
  Map<String, String> genderList = {"ERKAK": "МУЖСКОЙ", "AYOL": "ЖЕНЩИНА"};
  TextEditingController passportController = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  // AppModel? appModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String datee =
        "${selectedDate.toLocal()}".split(' ')[0].split("-").join(".");
    datee = datee.split('.').reversed.join(".");

    return AbsorbPointer(
      absorbing: !(widget.isAvailable ?? true),
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(
            context,
            "Идентификация",
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 89.h,
                      width: 325.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Серия и номер паспорта",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Container(
                            width: 325.w,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                width: 1.w,
                                color: Color(0xffE4E4E4),
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: passportController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                textCapitalization: TextCapitalization.characters,
                                inputFormatters: [passportFormat],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'AB 1231212',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFFC0C0C0),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      height: 89.h,
                      width: 325.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Год рождения",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // final DateTime? picked = await showDatePicker(
                              //   context: context,
                              //   builder: (context, child) {
                              //     return Theme(
                              //         data: ThemeData().copyWith(
                              //             colorScheme: ColorScheme(
                              //           brightness: Brightness.dark,
                              //           primary: AppConstant.primaryColor,
                              //           onPrimary: Colors.white,
                              //           secondary: Colors.green,
                              //           onSecondary: Colors.grey,
                              //           error: Colors.red,
                              //           onError: Colors.red,
                              //           background: AppConstant.primaryColor,
                              //           onBackground: AppConstant.primaryColor,
                              //           surface: Colors.grey,
                              //           onSurface: AppConstant.primaryColor,
                              //         )),
                              //         child: child ?? SizedBox());
                              //   },
                              //   initialDate: selectedDate,
                              //   firstDate: DateTime(1900),
                              //   lastDate: DateTime.now(),
                              // );
                              // if (picked != null && picked != selectedDate) {
                              //   setState(() {
                              //     selectedDate = picked;
                              //     selectedColor = Colors.black;
                              //   });
                              // }
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              height: 50.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  width: 1.sp,
                                  color: const Color(0xffE8E8E8),
                                ),
                              ),
                              child: TextFormField(
                                controller: datecontroller,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                textCapitalization: TextCapitalization.characters,
                                keyboardType: TextInputType.number,
                                inputFormatters: [dateMaskformat],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '31.12.2000',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFFC0C0C0),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
        
                              //  Text(
                              //   datee,
                              //   style: TextStyle(
                              //     color: selectedColor,
                              //     fontSize: 16.sp,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                            ),
                          ),
                        ],
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
                      height: 89.h,
                      width: 325.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Выберите пол",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // final DateTime? picked = await showDatePicker(
                              //   context: context,
                              //   builder: (context, child) {
                              //     return Theme(
                              //         data: ThemeData().copyWith(
                              //             colorScheme: ColorScheme(
                              //           brightness: Brightness.dark,
                              //           primary: AppConstant.primaryColor,
                              //           onPrimary: Colors.white,
                              //           secondary: Colors.green,
                              //           onSecondary: Colors.grey,
                              //           error: Colors.red,
                              //           onError: Colors.red,
                              //           background: AppConstant.primaryColor,
                              //           onBackground: AppConstant.primaryColor,
                              //           surface: Colors.grey,
                              //           onSurface: AppConstant.primaryColor,
                              //         )),
                              //         child: child ?? SizedBox());
                              //   },
                              //   initialDate: selectedDate,
                              //   firstDate: DateTime(1900),
                              //   lastDate: DateTime.now(),
                              // );
                              // if (picked != null && picked != selectedDate) {
                              //   setState(() {
                              //     selectedDate = picked;
                              //     selectedColor = Colors.black;
                              //   });
                              // }
        
                            },
                            child: Container(
                              //  padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  width: 1.sp,
                                  color: const Color(0xffE8E8E8),
                                ),
                              ),
                              child: new DropdownButton(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                
                                borderRadius: BorderRadius.circular(6.r),
                                hint: Text("Выберите пол",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                                underline: SizedBox(),
                                // border: Border.all(
                                //   width: 1.sp,
                                //   color: const Color(0xffE8E8E8),
                                // ),
                                icon: Transform.rotate(
                                  angle: pi/2,
                                  child: Icon(CupertinoIcons.forward)),
                                isExpanded: true,
                                value: gender,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    gender = newValue ?? gender;
                                  });
                                },
                                items: genderList.keys
                                    .toList()
                                    .map((String location) {
                                  return DropdownMenuItem<String>(
                                    value: location,
                                    child: new Text(
                                      genderList[location]!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
        
                            //  Container(
                            //   alignment: Alignment.centerLeft,
                            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                            //   height: 50.h,
                            //   width: MediaQuery.of(context).size.width,
                            //   decoration: BoxDecoration(
                            //     color: Colors.red,
                            //     borderRadius: BorderRadius.circular(6.r),
                            //     border: Border.all(
                            //       width: 1.sp,
                            //       color: const Color(0xffE8E8E8),
                            //     ),
                            //   ),
                            //   child: Text(
                            //     datee,
                            //     style: TextStyle(
                            //       color: selectedColor,
                            //       fontSize: 16.sp,
                            //       fontWeight: FontWeight.w400,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocListener<MyidCheckBloc, MyidCheckState>(
                    child: SizedBox(),
                    listener: (context, state) async {
                      if (state is MyidCheckWaitingState) {
                        loadingService.showLoading(context);
                      } else if (state is MyidCheckErrorState) {
                        loadingService.closeLoading(context);
                        if (state.statusCode == 401) {
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
                        } else {
                          Flushbar(
                            backgroundColor: Colors.red.shade700,
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
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
                      } else if (state is MyidCheckSuccessState) {
                        final data = await MyIdService.request(
                            KEY_DATE_OF_BIRTH: datecontroller.text,
                            KEY_PASSPORT_DATA:
                                passportController.text.replaceAll(" ", ""));
        
                        MyIdResult? result = data?["result"];
                        String? error = data?["error"];
                        for (var i = 0; i < 20; i++) {
                          print(">>>>>>>>>>>>>>>>>>> 000000");
                        }
                        for (var i = 0; i < 20; i++) {
                          print("code >>>>>>>>>>>>>>>>>>");
                        }
                        print(result?.code);
                         for (var i = 0; i < 20; i++) {
                          print("base64 >>>>>>>>>>>>>>>>>>");
                        }
                        print(result?.base64);
        
                        myidImageInBase64 = result?.base64;
                        if (myidImageInBase64 == null ) {
                           loadingService.closeLoading(context);
                        Flushbar(
                            backgroundColor: Colors.red.shade700,
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            flushbarPosition: FlushbarPosition.TOP,
                            flushbarStyle: FlushbarStyle.GROUNDED,
                            isDismissible: true,
                            message: "Произошла ошибка. Фото клиент отсутствий",
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
                          
                          return ;
                        }else{
                             
                                MyidController.getMe(
                            context,
                            code: result!.code,
                            passport: passportController.text.replaceAll(" ", ""),
                            birthDate: datecontroller.text.split(".").reversed.toList().join("-"),
                            base64Image : myidImageInBase64,
        
                            
                          );
                        }
        
                        // if (result?.code != null) {
                        //   MyidController.getMe(
                        //     context,
                        //     code: result!.code!,
                        //     passport: passportController.text,
        
                        //   );
        
                        //   //  ZayavkaController.update1(context);
                        // }
                        
                        //  else {
                        //   loadingService.closeLoading(context);
                        //   Flushbar(
                        //     backgroundColor: Colors.red.shade700,
                        //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        //     flushbarPosition: FlushbarPosition.TOP,
                        //     flushbarStyle: FlushbarStyle.GROUNDED,
                        //     isDismissible: true,
                        //     message: "Произошла ошибка. Повторите попытку позже.",
                        //     messageColor: Colors.white,
                        //     messageSize: 18.sp,
                        //     icon: Icon(
                        //       Icons.error,
                        //       size: 28.0,
                        //       color: Colors.white,
                        //     ),
                        //     duration: Duration(minutes:1),
                        //     leftBarIndicatorColor: Colors.red.shade700,
                        //   ).show(context);
                        // }
                      }
                    }),
                BlocListener<MyidBloc, MyidState>(
                    child: SizedBox(),
                    listener: (context, state) async {
                      if (state is MyidErrorState) {
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
        
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.login,
                            (route) => false,
                          );
                        } else {
                          Flushbar(
                            backgroundColor: Colors.red.shade700,
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            flushbarPosition: FlushbarPosition.TOP,
                            flushbarStyle: FlushbarStyle.GROUNDED,
                            isDismissible: true,
                            message: state.message ?? "Xatolik bor",
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
                      } else if (state is MyidSuccessState) {
                        myidInfo = state.data;
                        print("state data >>>>>>>>");
                        print("state data >>>>>>>>");
                        print("state data >>>>>>>>");
                        print("state data >>>>>>>>");
                        print("state data >>>>>>>>");
        
                        print("state data >>>>>>>>");
                        print("state data >>>>>>>>" + myidInfo.toString());
                        if (myidInfo != null) {
                          String? passport =
                              myidInfo?["profile"]["doc_data"]["pass_data"];
                          String? fullname = myidInfo!["profile"]["common_data"]
                                      ["first_name"]
                                  .toString()
                                  .capitalize() +
                              " " +
                              myidInfo!["profile"]["common_data"]["last_name"]
                                  .toString()
                                  .capitalize() +
                              " " +
                              myidInfo!["profile"]["common_data"]["middle_name"]
                                  .toString()
                                  .capitalize();
                          String? pinfl = myidInfo!["profile"]["common_data"]["pinfl"];
        
                          // for (var i = 0; i < 40; i++) {
                          //   print("await HiveService.create_or_updateZayavka({");
        
                          // }
                          // print({ "id": state.data["id"].toString(),
                          //   "myidInfo": myidInfo,
                          //   "birthDate":
                          //       "${selectedDate.toLocal()}".split(' ')[0]});
        
        
                          await ZayavkaController.update1(
                            context,
                            fullname: fullname,
                            passport: passport,
                            pinfl: pinfl
        
                          );
                          print(">>>>>>>>>>>>>>");
                          print(myidInfo?["profile"]["address"]);
                        }
                      }
                    }),
                BlocListener<UpdateApp1Bloc, UpdateApp1State>(
                    child: SizedBox(),
                    listener: (context, state) async {
                      if (state is UpdateApp1ErrorState) {
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
        
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.login,
                            (route) => false,
                          );
                        } else {
                          Flushbar(
                            backgroundColor: Colors.red.shade700,
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            flushbarPosition: FlushbarPosition.TOP,
                            flushbarStyle: FlushbarStyle.GROUNDED,
                            isDismissible: true,
                            message: "Xatolik Bor",
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
                      } else if (state is UpdateApp1SuccessState) {
                        loadingService.closeLoading(context);
                        print("writing");
        
                        // print(
                        //   {
                        //       "id": state.data["id"].toString(),
                        //   "myidInfo":myidInfo,
                        //   "birthDate":"${selectedDate.toLocal()}".split(' ')[0]
                        //   }
                        // );
        
                        if (BlocProvider.of<GetAppsBloc>(context).state
                            is GetAppsSuccessState) {
                          final apps = (BlocProvider.of<GetAppsBloc>(context)
                                  .state as GetAppsSuccessState)
                              .apps;
                          // apps.last["myidInfo"] = myidInfo;
                          AppController.update1(
                            context,
                            app: state.data,
                          );
                          // print({
                          //   "id": state.data["id"].toString(),
                          //   // "myidInfo": myidInfo,
                          //   "birthDate": datecontroller.text,
                          //   "IdentificationVideoBase64": myidImageInBase64
                          // });
                          await HiveService.create_or_updateZayavka({
                            "id": state.data["id"].toString(),
                            "birthDate": datecontroller.text,
                            "IdentificationVideoBase64": myidImageInBase64,
                            "myidInfo": myidInfo,
                          });
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.customerDataView,
                            arguments: {
                              "appModel": state.data,
                            },
                          );
                        }
                      }
                    }),
                SizedBox(
                  height: 48.h,
                ),
                customButton(context, 'Поиск', () async {
                  print(datee);
                  print(passportController.text.replaceAll(" ", ""));
                  print(passportController.text.replaceAll(" ", "").length);
                  print(datee);
                  if (passportController.text.replaceAll(" ", "").length == 9 &&
                      datecontroller.text.replaceAll(".", "").length == 8 &&
                      gender != null) {
                    await MyidController.check(
                      context,
                      passport: passportController.text.replaceAll(" ", ""),
                      date: datecontroller.text,
                      gender: gender!,
                    );
                  }
                },
                    passportController.text.replaceAll(" ", "").length == 9 &&
                            datecontroller.text.replaceAll(".", "").length == 8 && gender!=null
                        ? AppConstant.primaryColor
                        : Colors.grey.shade400,
                    buttonWidth: 325.w),
                SizedBox(
                  height: 80.h,
                ),
                Image.asset(
                  "assets/images/my_id_logo.png",
                  width: 260.w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
