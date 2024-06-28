import 'package:flutter_windowmanager/flutter_windowmanager.dart';

Future<void> noScreenshotSecure() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}


Future<void> RemoveScreenshotSecure() async {
  await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
}
