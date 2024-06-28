import 'package:hive_flutter/hive_flutter.dart';

hiveInit() async {
  await Hive.initFlutter();
  await Hive.openBox('premium');
}
