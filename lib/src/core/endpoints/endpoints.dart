import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static const int receiveTimeout = 60000;
  static const int connectionTimeout = 60000;

  static String myid_client_id = dotenv.env["myid_client_id"] ?? "";

  static String myid_clientHashId = dotenv.env["myid_clientHashId"] ?? "";
  static String myid_clientHash = dotenv.env["myid_clientHash"] ?? "";

  static String base_url = dotenv.env["base_url"] ?? "";
  static String domen = dotenv.env["domen"] ?? "";
  static String login = dotenv.env["login"] ?? "";
  static String myid = dotenv.env["myid"] ?? "";
  static String myidCheck = dotenv.env["myid-check"] ?? "";

  static String UpdateApp = dotenv.env["app-Update"] ?? "";
  static String getApps = dotenv.env["app-getAll"] ?? "";

  static String UpdateApp1 = dotenv.env["UpdateApp1"] ?? "";
  static String UpdateApp2 = dotenv.env["UpdateApp2"] ?? "";
  static String UpdateApp3 = dotenv.env["UpdateApp3"] ?? "";
  static String UpdateApp4 = dotenv.env["UpdateApp4"] ?? "";
  static String UpdateApp5 = dotenv.env["UpdateApp5"] ?? "";
  static String UpdateApp6 = dotenv.env["UpdateApp6"] ?? "";
  static String UpdateApp7 = dotenv.env["UpdateApp7"] ?? "";
  static String UpdateAppFinish = dotenv.env["UpdateAppFinish"] ?? "";
  static String GetPercents = dotenv.env["GetPercents"] ?? "";
  static String Merchant = dotenv.env["Merchant"] ?? "";
  static String Fillial = dotenv.env["Fillial"] ?? "";

  static String CancelByClient = dotenv.env["CancelByClient"] ?? "";
  static String Error = dotenv.env["error"] ?? "";

  static String cardCheck = dotenv.env["cardCheck"] ?? "";
  static String cardSend = dotenv.env["cardSend"] ?? "";
  static String cardVerify = dotenv.env["cardVerify"] ?? "";
  static String secretKey = dotenv.env["secretKey"] ?? "";
}
