import 'package:premium_pay_new/export_files.dart';
import 'package:premium_pay_new/src/blocs/6_card/check/check_bloc.dart';
import 'package:premium_pay_new/src/blocs/6_card/send/sendOtp_bloc.dart';
import 'package:premium_pay_new/src/blocs/6_card/verify/verify_bloc.dart';

class CardController {
  static Future<void> check(BuildContext context,
      {required String? card}) async {
    try {
      await BlocProvider.of<CardCheckBloc>(context).post(card: card);
    } catch (e, track) {
      print("MerchantManager Error >>" + e.toString());
      print("MerchantManager track >>" + track.toString());
    }
  }

  static Future<void> sendOtp(BuildContext context,
      {required String? card, required String? expiry}) async {
    try {
      await BlocProvider.of<CardSendOtpBloc>(context)
          .post(card: card, expiry: expiry);
    } catch (e, track) {
      print("MerchantManager Error >>" + e.toString());
      print("MerchantManager track >>" + track.toString());
    }
  }

  static Future<void> setIntialsendOtp(
    BuildContext context,
  ) async {
    try {
      await BlocProvider.of<CardSendOtpBloc>(context).setIntial();
    } catch (e, track) {
      print("MerchantManager Error >>" + e.toString());
      print("MerchantManager track >>" + track.toString());
    }
  }

  static Future<void> verify(
    BuildContext context, {
    required String? id,
    required String? code,
    required String? type,
  }) async {
    try {
      await BlocProvider.of<CardVerifyBloc>(context)
          .post(id: id, type: type, code: code);
    } catch (e, track) {
      print("MerchantManager Error >>" + e.toString());
      print("MerchantManager track >>" + track.toString());
    }
  }

  static Future<void> setIntialVerify(
    BuildContext context,
  ) async {
    try {
      await BlocProvider.of<CardVerifyBloc>(context).setIntial();
    } catch (e, track) {
      print("MerchantManager Error >>" + e.toString());
      print("MerchantManager track >>" + track.toString());
    }
  }
}
