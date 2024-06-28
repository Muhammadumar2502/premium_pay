import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class SelfieWithPassportView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  SelfieWithPassportView(
      {Key? key, required this.appModel, this.isAvailable = true})
      : super(key: key);

  @override
  State<SelfieWithPassportView> createState() => _SelfieWithPassportViewState();
}

class _SelfieWithPassportViewState extends State<SelfieWithPassportView> {
  LoadingService loadingService = LoadingService();

  File? image;
  TextEditingController maxAmountEditingController = TextEditingController();
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, imageQuality: 100, );
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Rasm yuklashda xatolik: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String t = maxAmountEditingController.text;
    t = t.replaceAll(" ", "");
    bool checkMaxAmount =
        (int.tryParse(t) ?? 0) <= 24000000 && (int.tryParse(t) ?? 0) >= 500000;
    print(t);
    print(checkMaxAmount);
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
            "Селфи с паспортом",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                   pickImage(ImageSource.camera);
                },
                child: Container(
                  width: 1.sw,
                  height: 420.h,
              
                  // padding: EdgeInsets.symmetric(horizontal: 140.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: image ==null ? null : DecorationImage(image: FileImage(File(image!.path)),filterQuality: FilterQuality.high,fit: BoxFit.cover)
                  ),
                  child:image ==null?  Container(
                      padding: EdgeInsets.symmetric(horizontal: 140.w),
                      child: SvgPicture.asset(
                        "assets/icons/image.svg",
                      )):null,
                ),
              ),
              Divider(
                thickness: 1.h,
                color: Color(0XFF151522).withOpacity(0.1),
              ),
              SizedBox(
                height: 32.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 89.h,
              //       width: 325.w,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "500 000 сум - 24 500 000 сум",
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 15.sp,
              //               fontWeight: FontWeight.w300,
              //             ),
              //           ),
              //           Container(
              //             width: 325.w,
              //             alignment: Alignment.centerLeft,
              //             padding: EdgeInsets.symmetric(horizontal: 15.w),
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(5.r),
              //               border: Border.all(
              //                 width: 1.w,
              //                 color: Color(0xffE4E4E4),
              //               ),
              //             ),
              //             child: TextField(
              //                 onChanged: (value) {
              //           setState(() {});
              //         },
              //         controller: maxAmountEditingController,
              //         inputFormatters: [ThousandsSeparatorInputFormatter()],
              //         keyboardType: TextInputType.number,
              //               style: TextStyle(
              //                   fontSize: 15.sp,
              //                   fontWeight: FontWeight.w300,
              //                   height: 1),
              //               decoration: InputDecoration(
              //                   contentPadding: EdgeInsets.symmetric(
              //                       horizontal: 10.w, vertical: 15.h),
              //                   isDense: true,
              //                   border: const OutlineInputBorder(
              //                       borderSide: BorderSide.none),
              //                   hintStyle: TextStyle(
              //                       fontSize: 15.sp,
              //                       fontWeight: FontWeight.w300,
              //                       color: Color(0xffC0C0C0)),
              //                   hintText: "Товар сумма",
                                
              //                    suffixText: "сум",
                       
                                
              //                   ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 32.h,
              // ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 25.w),child:   customButton(
                context,
                "Отправить на скоринг",
                () async{
                  // for (var i = 0; i < 14; i++) {
                  //   print("((((object))))");
                  // }
                    // Map? zayavka =
                    //     HiveService.getZayavka("${widget.appModel["id"]}");
                        
                    // String? cardNumber = zayavka?["cardNumber"];
                    // String? birthDate = zayavka?["birthDate"];
                    // String? IdentificationVideoBase64 = zayavka?["IdentificationVideoBase64"];
      
                    // print(cardNumber);
                    // print(birthDate);
                    // print((zayavka as Map).keys);
                    // print("${widget.appModel["id"]}");
                    
                    
      
      
                    // print("IdentificationVideoBase64:"+ IdentificationVideoBase64.toString());
                  if (image != null) {
                    String selfie_with_passport =
                        Base64Service().filetoBase64(image!.path);
                    print(selfie_with_passport.length);
                    // return ;
                    Map? zayavka =
                        HiveService.getZayavka("${widget.appModel["id"]}");
                    String? cardNumber = zayavka?["cardNumber"];
                    String? birthDate = zayavka?["birthDate"];
                    String? IdentificationVideoBase64 = zayavka?["IdentificationVideoBase64"];
      
                    
                    print("IdentificationVideoBase64:"+ IdentificationVideoBase64.toString());
                   
                    await ZayavkaController.update3(context,
                        id: "${widget.appModel["id"]}",
                        selfie_with_passport: selfie_with_passport,
                        max_amount: int.tryParse(maxAmountEditingController.text
                            .replaceAll(" ", "")),
                        cardNumber: cardNumber,
                        birthDate: birthDate,
                        IdentificationVideoBase64: IdentificationVideoBase64,
                        );
                    
                  }
                },
                image != null 
                    ? Color(0xffBE52F2)
                    : Colors.grey.shade400,
                buttonWidth: 325.w,
              ),
            ),
      
                BlocListener<UpdateApp3Bloc, UpdateApp3State>(
                  child: SizedBox(),
                  listener: (context, state) async {
                    if (state is UpdateApp3WaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is UpdateApp3ErrorState) {
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
                    } else if (state is UpdateApp3SuccessState) {
                      loadingService.closeLoading(context);
      
                      widget.appModel = state.data;
                      AppController.update3(context,
                          id: widget.appModel["id"].toString(),
                          app: widget.appModel);
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.scoringView,
                        arguments: {
                          "appModel": widget.appModel,
                        },
                      );
                    }
                  }),
          
      
      
            ],
          ),
        ),
      ),
    );

    // return AbsorbPointer(
    //   absorbing: !(widget.isAvailable ?? true),
    //   child: Scaffold(
    //     appBar: customAppBar(
    //       context,
    //       "Селфи с паспортом",
    //     ),
    //     resizeToAvoidBottomInset: true,
    //     body: SingleChildScrollView(
    //       padding: EdgeInsets.symmetric(horizontal: 16.w),
    //       child: Column(
    //         children: [
    //           SizedBox(height: 16.h),
    //           GestureDetector(
    //             onTap: () {
    //               pickImage(ImageSource.camera);
    //               // customBottomSheet(context, confirmationWidget());
    //             },
    //             child: Container(
    //               width: MediaQuery.of(context).size.width,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(6.r),
    //                 border: Border.all(
    //                   width: 1.sp,
    //                   color: const Color(0xffE8E8E8),
    //                 ),
    //               ),
    //               padding: EdgeInsets.all(20.w),
    //               child: image != null
    //                   ? Image.file(
    //                       image!,
    //                       height: 300.h,
    //                       fit: BoxFit.contain,
    //                     )
    //                   : Image.asset(
    //                       'assets/img/select.png',
    //                       scale: 2,
    //                     ),
    //             ),
    //           ),
    //           SizedBox(height: 64.h),
    //           Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               // Text(
    //               //   'Минимальная сумма  (500 000 сум)',
    //               //   style: TextStyle(
    //               //     color: Colors.black,
    //               //     fontSize: 12.sp,
    //               //     fontWeight: FontWeight.w400,
    //               //   ),
    //               // ),
    //               // SizedBox(height: 5.h),

    //               Padding(
    //                 padding: EdgeInsets.all(4.0.h),
    //                 child: Text(
    //                   '500 000 сум  -  24 500 000 сум',
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 12.sp,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 4.h,
    //               ),
    //               Container(
    //                 alignment: Alignment.centerLeft,
    //                 padding: EdgeInsets.symmetric(horizontal: 16.w),
    //                 height: 50.h,
    //                 width: MediaQuery.of(context).size.width,
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.circular(6.r),
    //                   border: Border.all(
    //                     width: 1.sp,
    //                     color: const Color(0xffE8E8E8),
    //                   ),
    //                 ),
    //                 child: TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {});
    //                   },
    //                   controller: maxAmountEditingController,
    //                   inputFormatters: [ThousandsSeparatorInputFormatter()],
    //                   keyboardType: TextInputType.number,
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 16.sp,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                   decoration: InputDecoration(
    //                     suffixText: "сум",
    //                     border: InputBorder.none,
    //                     hintText: 'Общая сумма',
    //                     hintStyle: TextStyle(
    //                       color: Colors.grey.shade400,
    //                       fontSize: 16.sp,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,

    //                     // isDense: false,
    //                     // prefixIcon: Text("\$"),
    //                     // suffixIconConstraints:
    //                     //     BoxConstraints(minWidth: 0, minHeight: 0),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           // Expanded(child: SizedBox(height: 16.h)),
    //           SizedBox(height: 168.h),
    //           customButton(
    //             context,
    //             'Подтвердить',
    //             () async {
    //               if (image != null && checkMaxAmount) {
    //                 String selfie_with_passport =
    //                     Base64Service().filetoBase64(image!.path);
    //                 print(selfie_with_passport.length);
    //                 // return ;
    //                 Map? zayavka =
    //                     HiveService.getZayavka("${widget.appModel["id"]}");
    //                 String? cardNumber = zayavka?["cardNumber"];
    //                 String? birthDate = zayavka?["birthDate"];
    //                 String? myidImageInBase64 = zayavka?["myidImageInBase64"];

    //                 await ZayavkaController.update3(context,
    //                     id: "${widget.appModel["id"]}",
    //                     selfie_with_passport: selfie_with_passport,
    //                     max_amount: int.parse(maxAmountEditingController.text
    //                         .replaceAll(" ", "")),
    //                     cardNumber: cardNumber,
    //                     birthDate: birthDate,
    //                     IdentificationVideoBase64: myidImageInBase64);
    //               }
    //             },
    //             Colors.deepPurple
    //                 .withOpacity(image != null && checkMaxAmount ? 1 : 0.3),
    //           ),
    //           BlocListener<UpdateApp3Bloc, UpdateApp3State>(
    //               child: SizedBox(),
    //               listener: (context, state) async {
    //                 if (state is UpdateApp3WaitingState) {
    //                   loadingService.showLoading(context);
    //                 } else if (state is UpdateApp3ErrorState) {
    //                   loadingService.closeLoading(context);
    //                   if (state.statusCode == 401) {
    //                     Future.wait([
    //                       CacheService.remove(
    //                         CacheService.token,
    //                       ),
    //                       CacheService.remove(
    //                         CacheService.user,
    //                       )
    //                     ]);
    //                     Flushbar(
    //                       backgroundColor: Colors.red.shade700,
    //                       dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    //                       flushbarPosition: FlushbarPosition.TOP,
    //                       flushbarStyle: FlushbarStyle.GROUNDED,
    //                       isDismissible: true,
    //                       message: "Пожалуйста, войдите снова",
    //                       messageColor: Colors.white,
    //                       messageSize: 18.sp,
    //                       icon: Icon(
    //                         Icons.error,
    //                         size: 28.0,
    //                         color: Colors.white,
    //                       ),
    //                       duration: Duration(minutes:1),
    //                       leftBarIndicatorColor: Colors.red.shade700,
    //                     ).show(context);

    //                     Navigator.pushNamedAndRemoveUntil(
    //                       context,
    //                       RouteNames.login,
    //                       (route) => false,
    //                     );
    //                   } else {
    //                     Flushbar(
    //                       backgroundColor: Colors.red.shade700,
    //                       dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    //                       flushbarPosition: FlushbarPosition.TOP,
    //                       flushbarStyle: FlushbarStyle.GROUNDED,
    //                       isDismissible: true,
    //                       message: state.message,
    //                       messageColor: Colors.white,
    //                       messageSize: 18.sp,
    //                       icon: Icon(
    //                         Icons.error,
    //                         size: 28.0,
    //                         color: Colors.white,
    //                       ),
    //                       duration: Duration(minutes:1),
    //                       leftBarIndicatorColor: Colors.red.shade700,
    //                     ).show(context);
    //                   }
    //                 } else if (state is UpdateApp3SuccessState) {
    //                   loadingService.closeLoading(context);

    //                   widget.appModel = state.data;
    //                   AppController.update3(context,
    //                       id: widget.appModel["id"].toString(),
    //                       app: widget.appModel);
    //                   Navigator.pushReplacementNamed(
    //                     context,
    //                     RouteNames.scoringView,
    //                     arguments: {
    //                       "appModel": widget.appModel,
    //                     },
    //                   );
    //                 }
    //               }),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  
  }
}
