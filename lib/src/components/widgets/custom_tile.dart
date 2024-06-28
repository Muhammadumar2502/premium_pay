import 'package:premium_pay_new/export_files.dart';

// // ignore: must_be_immutable
// class CustomTile extends StatelessWidget {
//   String? status;
//   Color? color;
//   String? fullname;
//   String? canceled_reason;
//   String? finished_time;
//   String? status_text;
//   var app;
//   CustomTile({super.key, required this.app}) {
//     status = app["status"];
//     finished_time = app["created_time"];
//     canceled_reason = app["canceled_reason"];
//     fullname = app["fullname"] ?? "";
//     // print(app.toString());
//     if (status == "finished") {
//       status_text ="Успешно";
//       color = const Color(0xFF1BDA17);
//     } else if (status == "progress") {
//       if (app["step"] == 3) {
//         status_text = "Скоринг";
//         color = const Color(0xFFECA400);
//       } else if (app["step"] == 4) {
//         status_text = "Одобрен ";
//         color = const Color(0xFF1BDA17);
//       } else {
//         status_text = "Ожидающий";
//         color = const Color(0xFFECA400);
//       }
//     } else if (status == "canceled_by_client") {
//        status_text ="Отказано";
//       color = Color.fromARGB(255, 255, 25, 25);
//     }  else if(status == "canceled_by_daily"){
//       status_text ="Отказано";
//       color =  Color(0xff5400A9);
//     }

//     else {
//       status_text ="Отказано";
//       color = Color.fromARGB(255, 122, 8, 8);
//     }
//     if (finished_time != null) {
//       finished_time =
//           finished_time!.split("T")[1].split(".")[0].substring(0, 5);
//     } else {
//       finished_time = app["created_time"]!.split("T")[1].split(".")[0].substring(0, 5);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {

//         if (status == "canceled_by_client" || status == "canceled_by_scoring" || status == "canceled_by_daily" ) {
//           Navigator.pushNamed(context, RouteNames.canceledAppView,
//               arguments: {"app": app});
//         } else if (status == "progress") {
//           Navigator.pushNamed(context, RouteNames.progressAppView,
//               arguments: {"app": app});
//         } else if (status == "finished") {
//           Navigator.pushNamed(context, RouteNames.finishedAppView,
//               arguments: {"app": app},);
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8.h),
//         width: MediaQuery.of(context).size.width,
//         height: 75.h,
//         decoration: BoxDecoration(
//           color: const Color(0xFFFFFFFF),
//           border: Border.all(
//             color: const Color(0xFFC0C0C0),
//           ),
//           borderRadius: BorderRadius.circular(6.r),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     fullname!,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     status_text!,
//                     style: TextStyle(
//                       color: color,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.h),

//              Text(
//                         finished_time!,
//                         style: TextStyle(
//                           color: const Color(0xFFC0C0C0),
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
class CustomTile extends StatelessWidget {
  String? statusImage;
  String? status;
  String? fullname;
  String? finished_time;
  String? avatar;
  Color? color;
  String? canceled_reason;
  String? status_text;
  var app;

  // CustomTile({
  //   super.key,
  //   required this.status,
  //   required this.fullname,
  //   required this.finished_time,
  //   required this.avatar,
  // });
  CustomTile({
    super.key,
    required this.app,
    this.avatar,
    this.status,
    this.statusImage,
    this.status_text,
    this.color,
    this.canceled_reason,
    this.finished_time,
    this.fullname,
  }) {
    status = app["status"];
    finished_time = app["created_time"];
    canceled_reason = app["canceled_reason"];
    fullname = app["fullname"] ?? "";

    if (status == "finished" || status == "paid") {
      status_text = "Успешно";
      statusImage = "assets/icons/check.svg";
      color = const Color(0xFF1BDA17);
    } else if (status == "progress") {
      statusImage = "assets/icons/clock.svg";
      if (app["step"] == 3) {
        status_text = "Скоринг";
        color = const Color(0xFFECA400);
      } else if (app["step"] == 4) {
        status_text = "Одобрен ";
        color = const Color(0xFF1BDA17);
      } else {
        status_text = "Ожидающий";
        color = const Color(0xFFECA400);
      }
    } else if (status == "canceled_by_client") {
      statusImage = "assets/icons/cancel.svg";
      status_text = "Отказано";
      color = Color.fromARGB(255, 255, 25, 25);
    } else if (status == "canceled_by_daily") {
      status_text = "Отказано";
      color = Color(0xff5400A9);
      statusImage = "assets/icons/cancel.svg";
    } else {
      status_text = "Отказано";
      color = Color.fromARGB(255, 122, 8, 8);
      statusImage = "assets/icons/cancel.svg";
    }
    if (finished_time != null) {
      finished_time =
          finished_time!.split("T")[1].split(".")[0].substring(0, 5);
    } else {
      finished_time =
          app["created_time"]!.split("T")[1].split(".")[0].substring(0, 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(status);
        if (status == "canceled_by_client" ||
            status == "canceled_by_scoring" ||
            status == "canceled_by_daily") {
          Navigator.pushNamed(context, RouteNames.canceledAppView,
              arguments: {"app": app});
        } else if (status == "progress") {
          Navigator.pushNamed(context, RouteNames.progressAppView,
              arguments: {"app": app});
        } else if (status == "finished" || status == "paid") {
          // Navigator.pushNamed(context, RouteNames.progressAppView,
          // arguments: {"app": app});
          Navigator.pushNamed(
            context,
            RouteNames.finishedAppView,
            arguments: {"app": app},
          );
        }
      },
      child: ListTile(
  //        dense: true,
  // visualDensity: VisualDensity(vertical: -3),
        // minVerticalPadding: 20.h,
        leading: Container(
          height: 40.h,
          width: 40.h,
          
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.w,
              color: Color(0xFF999999),
            ),
          ),
          child: SvgPicture.asset(
            avatar!,
            height: 21.w,
            width: 21.w,
          ),
        ),
        title: Text(
          fullname!,
          style: TextStyle(
            color: Color(0Xff242424),
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        subtitle: Text(
          finished_time!,
          style: TextStyle(
            color: Color(0Xff242424).withOpacity(0.6),
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
          ),
        ),
        trailing: Transform.scale(
          scale: 1.4,
          child: SvgPicture.asset(statusImage!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
