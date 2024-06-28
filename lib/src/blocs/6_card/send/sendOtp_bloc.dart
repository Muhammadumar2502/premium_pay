import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_new/src/services/jwt/generate.dart';

import '../../../../export_files.dart';
import 'sendOtp_state.dart';

class CardSendOtpBloc extends Cubit<CardSendOtpState> {
  DioClient dioClient = DioClient();
  CardSendOtpBloc() : super(CardSendOtpIntialState());

  Future post({
    required String? card,
    required String? expiry,
    
  }) async {
    emit(CardSendOtpWaitingState());
    // await Future.delayed(Duration(seconds: 3));
    String? token = await CacheService.read(
      CacheService.token,
    );
    
    
    final data =  await JWTService.decode(
      {
        'cardNumber': card,
        'expiry' :expiry

    });
    print(data);
    print({'cardNumber': card,
       'expiry' :expiry});
    dio.Response response = await dioClient.post(
      Endpoints.cardSend,
      data: {
        "data": data
      },
        options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      final data = await JWTService.encode(response.data["data"].toString());
      print(data);
     emit(
          CardSendOtpSuccessState(
            data: data
          ),
        );
    } else {
      emit(
        CardSendOtpErrorState(
            title: response.data["name"], message: response.data["message"]),
      );
    }

    return response.data;
  }
    Future setIntial() async {
    emit(CardSendOtpIntialState());
   
  }

}
