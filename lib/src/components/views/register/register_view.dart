// ignore_for_file: deprecated_member_use

import 'package:premium_pay_new/export_files.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController loginNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoadingService loadingService = LoadingService();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<LoginBloc, LoginState>(
                  child: SizedBox(),
                  listener: (context, state) async {
                    if (state is LoginWaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is LoginErrorState) {
                      loadingService.closeLoading(context);
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
                    } else if (state is LoginSuccessState) {
                      loadingService.closeLoading(context);
                      Future.wait([
                        CacheService.write(
                          CacheService.token,
                          state.token.toString(),
                        ),
                        CacheService.write(
                          CacheService.user,
                          state.user,
                        )
                      ]);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.applicationView,
                        (route) => false,
                      );
                    }
                  }),
              Transform.scale(
                scale: 1.5,
                child: Image.asset(
                  "assets/logo_2.png",
                  height: 80.h,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                height: 80.h,
                width: 325.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Логин",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                        controller: loginNameController,
                        onChanged: (value) => setState(() {}),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            height: 1),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 15.h),
                          isDense: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xffC0C0C0),
                          ),
                          hintText: "Логин",
                          prefixIcon: Transform.scale(
                            scale: 0.6,
                            child: SvgPicture.asset(
                              "assets/icons/person.svg",
                              color: Color(0xffBE52F2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 80.h,
                width: 325.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Парол",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                        controller: loginPasswordController,
                        onChanged: (value) => setState(() {}),
                        obscureText: obscureText,
                        obscuringCharacter: "⋆",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 15.h,
                          ),
                          isDense: true,
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xffC0C0C0),
                          ),
                          hintText: "Парол",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset(
                              "assets/icons/lock.svg",
                              color: Color(0xffBE52F2),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: obscureText
                                  ? Color(0xffBE52F2)
                                  : Colors.black,
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (loginNameController.text.isNotEmpty &&
                      loginPasswordController.text.isNotEmpty) {
                    await LoginController.post(
                      context,
                      loginName: loginNameController.text,
                      loginPassword: loginPasswordController.text,
                    );
                  }
                },
                child: Container(
                  width: 327.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: loginNameController.text.isNotEmpty &&
                            loginPasswordController.text.isNotEmpty
                        ? Color(0xffBE52F2)
                        : Colors.grey.shade400,
                  ),
                  // decoration: BoxDecoration(
                  //   color: const Color(0xffBE52F2).withOpacity(
                  //       loginNameController.text.isNotEmpty &&
                  //               loginPasswordController.text.isNotEmpty
                  //           ? 1
                  //           : 0.4),
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: const Color(0xff323247).withOpacity(0.8),
                  //       offset: Offset(0, 4.h),
                  //       blurRadius: 4.r,
                  //       // blurStyle: BlurStyle.outer
                  //     ),
                  //   ],
                  // ),
                  child: Text(
                    "Кириш",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
