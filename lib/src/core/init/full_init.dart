import 'package:premium_pay_new/src/core/init/hive/hive_init.dart';
import 'package:premium_pay_new/export_files.dart';


// ignore: non_constant_identifier_names
Future<void> fullInit() async {
  widgetBuildInit();
  await dotenvInit();
  await SystemChrome_init();
  await initLanguages();
  await hiveInit();
}
