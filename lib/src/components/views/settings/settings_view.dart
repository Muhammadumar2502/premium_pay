import 'package:flutter/cupertino.dart';
import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class SettingsView extends StatefulWidget {
  SettingsView({Key? key, required this.section}) : super(key: key);
  String section;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool switchValue = false;
  int selectedLang = 0;
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
            "Настройки",
            style: TextStyle(
              color: Color(0XFF242424),
              fontSize: 18.sp,
             fontWeight: FontWeight.w600,
            ),
          ),
          leading: Builder(
            builder: (context) => GestureDetector(
              // onTap: () => Scaffold.of(context).openDrawer(),
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
              SizedBox(
                height: 80.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Выберите тему",
                      style: TextStyle(
                        color: Color(0XFFBE52F2),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Темный режим",
                      style: TextStyle(
                        color: Color(0XFF151522),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    CupertinoSwitch(
                        activeColor: Color(0XFFBE52F2),
                        value: switchValue,
                        onChanged: (v) {
                          switchValue = v;
                          setState(() {});
                        })
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
                height: 32.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Выберите язык",
                      style: TextStyle(
                        color: Color(0XFFBE52F2),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    3,
                    (index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                selectedLang = index;
                              }),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      [
                                        "Узбекский",
                                        "Русский",
                                        "Английский"
                                      ][index],
                                      style: TextStyle(
                                        color: Color(0XFF151522),
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Container(
                                      width: 24.w,
                                      height: 24.w,
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                          border: selectedLang == index
                                              ? null
                                              : Border.all(
                                                  width: 1.w,
                                                  color: Color(0xff242424)
                                                      .withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: selectedLang != index
                                              ? Colors.white
                                              : Color(0xffBE52F2),
                                          boxShadow: selectedLang != index
                                              ? null
                                              : [
                                                  BoxShadow(
                                                      color: Color(0xff242424)
                                                          .withOpacity(0.2),
                                                      blurRadius: 3.r,
                                                      offset: Offset(1.w, 1.h))
                                                ]),
                                      child: selectedLang == index
                                          ? SvgPicture.asset(
                                              "assets/icons/check.svg",
                                              // ignore: deprecated_member_use
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.h,
                              color: Color(0XFF151522).withOpacity(0.1),
                            ),
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }

  // List<String> name = [
  //   'O\'zbekcha',
  //   'English',
  //   'Русский',
  // ];
  // List<String> flag = [
  //   'assets/img/uz.png',
  //   'assets/img/us.png',
  //   'assets/img/ru.png',
  // ];
  // bool switch1 = false;
  // int radioListValue = 0;
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: customAppBar(context, widget.section),
  //     body: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16.w),
  //       child: Column(
  //         children: [
  //           SizedBox(height: 16.h),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: EdgeInsets.symmetric(vertical: 4.h),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(6.r),
  //               border: Border.all(
  //                 width: 1.sp,
  //                 color: const Color(0xffE8E8E8),
  //               ),
  //             ),
  //             padding: EdgeInsets.all(16.w),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Выберите тему',
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 SizedBox(height: 8.h),
  //                 ListTile(
  //                   contentPadding: const EdgeInsets.all(0),
  //                   leading: Image.asset(
  //                     'assets/img/moon.png',
  //                     width: 30.w,
  //                   ),
  //                   title: Text(
  //                     'Темный режим',
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   trailing: CupertinoSwitch(
  //                     value: switch1,
  //                     onChanged: (value) {
  //                       setState(
  //                         () {
  //                           switch1 = !switch1;
  //                         },
  //                       );
  //                       ThemeController.changeThemeBrightness(context);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 8.h),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: EdgeInsets.symmetric(vertical: 4.h),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(6.r),
  //               border: Border.all(
  //                 width: 1.sp,
  //                 color: const Color(0xffE8E8E8),
  //               ),
  //             ),
  //             padding: EdgeInsets.all(16.w),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Выберите язык',
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 SizedBox(height: 8.h),
  //                 Column(
  //                   children: List.generate(
  //                     3,
  //                     (index) {
  //                       return Container(
  //                         decoration: BoxDecoration(
  //                           border: index == 2
  //                               ? const Border()
  //                               : Border(
  //                                   bottom: BorderSide(
  //                                     width: 0.1.sp,
  //                                   ),
  //                                 ),
  //                         ),
  //                         child: RadioListTile(
  //                           controlAffinity: ListTileControlAffinity.trailing,
  //                           title: Row(
  //                             children: [
  //                               Image.asset(flag[index], width: 35.w),
  //                               SizedBox(width: 16.w),
  //                               Text(
  //                                 name[index],
  //                                 style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 16.sp,
  //                                   fontWeight: FontWeight.w400,
  //                                 ),
  //                                 textAlign: TextAlign.left,
  //                               ),
  //                             ],
  //                           ),
  //                           value: index,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               radioListValue = value!;
  //                             });
  //                           },
  //                           groupValue: radioListValue,
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Spacer(),
  //           customButton(
  //             context,
  //             'Применить',
  //             () {},
  //             Colors.deepPurple,

  //           ),
  //           SizedBox(height: 40.h),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
