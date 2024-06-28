import 'package:premium_pay_new/export_files.dart';

class CacheService {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static IOSOptions _getIosOptions() => IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );
  static FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(), iOptions: _getIosOptions());

  static Future<dynamic> read(String key) async {
    final data = await storage.read(key: key);
    if (data !=null) {
      return jsonDecode(data);
    }else{
    return null;
    }
  }

  static Future<void> write(String key, dynamic value) async {
   if (value !=null) {
      await storage.write(key: key, value: jsonEncode(value));
   }
  }

  static Future remove(String key) async {
    await storage.delete(key: key);
  }

  static String token = 'token';
  static String user = 'user';
}
