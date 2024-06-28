import 'package:hive/hive.dart';

class HiveService {

  static Box box = Hive.box("premium");
  HiveService._();

  // static Future read(String key) async {
  //   return await box.get(key);
  // }

  // static Future<void> write(String key, dynamic value) async {
  //   await box.put(key, value);
  // }

  // static Future remove(String key) async {
  //   await box.delete(key);
  // }


  static Future create_or_updateZayavka(Map data) async {
    await box.put(data["id"].toString(), data);
  }

  static  getZayavka(String id)  {
    return box.get(id);
  }





}
