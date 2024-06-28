import 'package:premium_pay_new/export_files.dart';

class MerchantController {
  static Future<void> post(BuildContext context) async {
    try {
      await BlocProvider.of<MerchantBloc>(context).get();
    } catch (e, track) {
      print("MerchantManager Error >>" + e.toString());
      print("MerchantManager track >>" + track.toString());
    }
  }
}
