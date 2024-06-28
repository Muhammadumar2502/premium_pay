import 'package:premium_pay_new/export_files.dart';

class LoadingService {
  bool showStatus =false;
  showLoading(BuildContext context) {
    showStatus =true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppConstant.primaryColor.withOpacity(0.3),
      // ignore: deprecated_member_use
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          content:
          
           SizedBox(
            width: 160.w,
            height: 160.w,
            child: Center(
              child: CircularProgressIndicator(
                  color:const Color(0xffBE52F2),
                  strokeWidth: 6.w,
                  strokeAlign: 2,
                  strokeCap: StrokeCap.round,
                  backgroundColor:const Color(0xffBE52F2).withOpacity(0.2),
                ),
            ),
          ),
        ),
      ),
    );
  }

  closeLoading(BuildContext context) {
    if (showStatus) {
      Navigator.pop(context);
    }
    
  }
}
