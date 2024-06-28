import 'package:premium_pay_new/export_files.dart';

class PercentsController {
  static Future<void> get(BuildContext context) async {
    try {
      await BlocProvider.of<GetPercentsBloc>(context).get();
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }
}
