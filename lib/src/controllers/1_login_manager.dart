import 'package:premium_pay_new/export_files.dart';

class LoginController {
  static Future<void> post(
    BuildContext context, {
    required String loginName,
    required String loginPassword,
  }) async {
    try {
      await BlocProvider.of<LoginBloc>(context).post(
        loginName: loginName,
        loginPassword: loginPassword,
      );
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }
}
