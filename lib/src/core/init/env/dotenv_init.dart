import 'package:premium_pay_new/export_files.dart';

dotenvInit() async {
  await dotenv.load(fileName: ".env");
}
