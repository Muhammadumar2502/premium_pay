import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:premium_pay_new/export_files.dart';

class JWTService {
  static Future<String?> decode(data) async {
    try {
      final jwt = JWT(data);
      final token = jwt.sign(SecretKey(Endpoints.secretKey));

      print('Signed token: $token\n');

      return token;
    } catch (e, track) {
      print(
        "error get device info  : \n" + e.toString() + "\n" + track.toString(),
      );
    }
  }

  static Future encode(token) async {
    try {
      final data = await JWT.verify(token, SecretKey(Endpoints.secretKey));

      print('Signed token: $data\n');

      return data.payload;
    } catch (e, track) {
      print(
        "error get device info  : \n" + e.toString() + "\n" + track.toString(),
      );
    }
  }
}
