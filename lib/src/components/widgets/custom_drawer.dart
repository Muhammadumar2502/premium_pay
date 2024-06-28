// ignore_for_file: deprecated_member_use

import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class customDrawer extends StatefulWidget {
  String? fullname;
  String? phoneNumber;
  customDrawer({super.key, required this.fullname, required this.phoneNumber});

  @override
  State<customDrawer> createState() => _customDrawerState();
}

class _customDrawerState extends State<customDrawer> {
  // String? fullname;
  // String? phoneNumber;
  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      shape: Border.all(style: BorderStyle.none),
      child: Column(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 250.h,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Color(0XFFBE52F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(400.w, 40.h),
                  bottomRight: Radius.elliptical(400.w, 40.h),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15.0,
                    spreadRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 10.h,
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            "assets/images/cancel.svg",
                            height: 32.h,
                            width: 32.w,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 72.h),
                    Text(
                      widget.fullname ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.phoneNumber ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 100.h),
          ListTile(
            leading: Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE4E4E4).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/zayavki.svg",
                color: Color(0xFFBE52F2),
              ),
            ),
            title: Text(
              'Заявки',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplicationView(),
                ),
                (r) => false,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              thickness: 1,
            ),
          ),
          ListTile(
            leading: Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE4E4E4).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/novizayavki.svg",
                color: Color(0xFFBE52F2),
              ),
            ),
            title: Text(
              'Новая заявка',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
            onTap: () {
              if (BlocProvider.of<GetAppsBloc>(context).state
                  is GetAppsSuccessState) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewApplicationView(),
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              thickness: 1,
            ),
          ),
          ListTile(
            leading: Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE4E4E4).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/info.svg",
                color: Color(0xFFBE52F2),
              ),
            ),
            title: Text(
              'Инфо',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoView(),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              thickness: 1,
            ),
          ),
          ListTile(
            leading: Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE4E4E4).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/setting.svg",
                color: Color(0xFFBE52F2),
              ),
            ),
            title: Text(
              'Настройки',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(
                    section: "bds",
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              thickness: 1,
            ),
          ),
          Spacer(),
          ListTile(
            leading: Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE4E4E4).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/logout.svg",
                color: Color(0xFFBE52F2),
              ),
            ),
            title: Text(
              'Выход',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
            onTap: () {
              customAlertDialog(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              thickness: 1,
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
