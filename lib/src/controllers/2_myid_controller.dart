import 'package:premium_pay_new/export_files.dart';

class MyidController {
  static Future<void> getMe(
    BuildContext context, {
    required String? code,
    required String? passport,
     required String? birthDate,
     required String? base64Image,
     
    
  }) async {
    try {
      await BlocProvider.of<MyidBloc>(context).getMe(
        code: code,
        passport: passport,
        birthDate :birthDate,
        base64Image:base64Image,
        
      );
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> check(
    BuildContext context, {
    required String passport,
    required String date,
    required String gender,
  }) async {
    try {
      await BlocProvider.of<MyidCheckBloc>(context).check(
        passport: passport,
        date:date,
        gender:gender,
      );
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }
}
