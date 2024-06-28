import 'package:premium_pay_new/export_files.dart';

customAppBar<Widget>(
  BuildContext context,
  String text, {
  action,
}) {
  return AppBar(
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
    actions: action ?? [],
    title: Text(
      text,
      style: TextStyle(
        color: Color(0XFF242424),
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    leading: Builder(
      builder: (context) => GestureDetector(
        onTap: () async {
          await customtoBack(
            context,
          );
        },
        child: Padding(
          padding: EdgeInsets.all(18.w),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
          ),
        ),
      ),
    ),
  );
}

Future<bool> customtoBack(BuildContext context, {appModel}) async {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
  return true;
  // if ((appModel?.step ?? 0) > 1) {
  //         LoadingService loadingService = LoadingService();

  //         try {
  //           loadingService.showLoading(context);
  //           final progress =
  //               ((await HiveService.read(HiveService.progress)) ?? []) as List;
  //           progress.removeWhere((element) {
  //             // print(">>>>>");
  //             // print(element["id"].toString());
  //             // print(appModel?.id.toString());
  //             // print(element["id"].toString() == appModel?.id.toString());
  //             return element["id"].toString() == appModel?.id.toString();
  //           });
  //           progress.add(appModel?.toJson());
  //           await HiveService.write(HiveService.progress, progress);
  //           await Future.delayed(
  //             Duration(milliseconds: 400),
  //           );
  //           loadingService.closeLoading(context);
  //         } catch (e) {
  //           loadingService.closeLoading(context);
  //         }
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, RouteNames.applicationView, (route) => false);
  //       } else {
  //         Navigator.of(context).pop();
  //       }
  //       return false;
}
