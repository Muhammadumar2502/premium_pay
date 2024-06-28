import 'package:premium_pay_new/export_files.dart';

void main() async {
  runZoned(() async {
    await fullInit();
    runApp(PremiumPayMobile());
    // ignore: deprecated_member_use
  }, onError: (error, stackTrace) {
    print('This is a pure Dart error');
    print(error);
    print(stackTrace);

    try {
      String str = error.toString() + "%0A" + stackTrace.toString() + " ...";
      ErrorHandlerController.sendMessage(message: str);
    } catch (e, track) {
      print(e);
      print(track);
    }
  });
}
