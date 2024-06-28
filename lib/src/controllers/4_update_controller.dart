import 'package:premium_pay_new/export_files.dart';

class ZayavkaController {
  static Future<void> update1(
    BuildContext context, {
    required String fullname,
    required String? passport,
    required String? pinfl
  }) async {
    try {
      await BlocProvider.of<UpdateApp1Bloc>(context)
          .post(fullname: fullname, passport: passport,pinfl: pinfl);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> update2(
    BuildContext context, {
    required String id,
    required String phoneNumber,
    required String phoneNumber2,
    required String cardNumber,
    required String? passport_date,
    required String? passport_by,
    required Map? address,
    required int? region_id,
    required String? cardId
  }) async {
    try {
      await BlocProvider.of<UpdateApp2Bloc>(context).post(
        id: id,
        phoneNumber: phoneNumber,
        phoneNumber2: phoneNumber2,
        cardNumber: cardNumber,
        passport_by: passport_by,
        passport_date: passport_date,
        address: address,
        region_id: region_id,
        cardId :cardId
      );
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> update3(BuildContext context,
      {required String id,
      String? selfie_with_passport,
      int? max_amount,
      String? cardNumber,
      String? birthDate,
      required String? IdentificationVideoBase64}) async {
    try {
      await BlocProvider.of<UpdateApp3Bloc>(context).post(
          id: id,
          max_amount: max_amount,
          selfie_with_passport: selfie_with_passport,
          cardNumber: cardNumber,
          birthDate: birthDate,
          IdentificationVideoBase64: IdentificationVideoBase64,);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> update5(BuildContext context,
      {required String id,
      required List products,
      required Map? device,
      required Map? location,
      required double amount,
      
      }) async {
    try {
      await BlocProvider.of<UpdateApp5Bloc>(context).post(
          id: id,
          device: device,
          products: products,
          location: location,
          amount: amount);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> update6(BuildContext context,
      {required String id,
      required String? expired_month,
      required double? payment_amount}) async {
    try {
      await BlocProvider.of<UpdateApp6Bloc>(context).post(
          id: id, payment_amount: payment_amount, expired_month: expired_month);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> updateFinish(BuildContext context,
      {required String id, required String contractPdf}) async {
    try {
      await BlocProvider.of<UpdateAppFinishBloc>(context)
          .post(id: id, contractPdf: contractPdf);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> update7(
    BuildContext context, {
    required String id,
    String? selfie,
  }) async {
    try {
      await BlocProvider.of<UpdateApp7Bloc>(context).post(
        id: id,
        selfie: selfie,
      );
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> cancelByClient(BuildContext context,
      {required String id, String? canceled_reason}) async {
    try {
      await BlocProvider.of<CancelByClientBloc>(context)
          .post(id: id, canceled_reason: canceled_reason);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }
}
