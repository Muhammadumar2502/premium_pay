import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_new/export_files.dart';

class ErrorHandlerController {
  static Future<void> sendMessage({required String message}) async {
    try {
     dio.Response response = await DioClient().post(Endpoints.Error,data: {
        "message" : message,
        "device": "MOBILE"
      });
      print("ErrorHandlerController ${response.statusCode}");
      print("ErrorHandlerController ${response.data}");
    } catch (e, track) {
      print("ErrorHandlerController Error >>" + e.toString());
      print("ErrorHandlerController track >>" + track.toString());
    }
  }
}
