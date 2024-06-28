import 'package:device_info_plus/device_info_plus.dart';
import 'package:premium_pay_new/export_files.dart';

class DeviceService {
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Future getinfo() async {
    try {
     if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        final data = androidDeviceInfo.data;
        return {
          "name": data["brand"].toString() + " " + data["device"],
          "id": data["id"].toString()
        };
     } else if(Platform.isIOS){
         IosDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.iosInfo;
        final data = androidDeviceInfo.data;
        for (var i = 0; i < 40; i++) {
          print(">>>>");
        }
        print(data);
        return {
          "name": data["name"].toString(),
          "id": data["identifierForVendor"].toString()
        };
     }
    } catch (e, track) {
      print(
        "error get device info  : \n" + e.toString() + "\n" + track.toString(),
      );
    }
  }
}
