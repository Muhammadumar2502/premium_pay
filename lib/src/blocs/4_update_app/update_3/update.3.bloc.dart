import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';
import 'update.3.state.dart';

class UpdateApp3Bloc extends Cubit<UpdateApp3State> {
  DioClient dioClient = DioClient();
  UpdateApp3Bloc() : super(UpdateApp3IntialState());

  Future post({
    required String id,
    required String? selfie_with_passport,
    required int? max_amount,
    required String? cardNumber,
    required String? birthDate,
    required String? IdentificationVideoBase64
  }) async {
    emit(UpdateApp3WaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    print({
      "id": id,
        "max_amount": 50000000,
        // "selfie_with_passport": selfie_with_passport,
        "cardNumber":cardNumber,
        "birthDate":birthDate
    });
    dio.Response response = await dioClient.post(
      Endpoints.UpdateApp3,
      data: {
        "id": id,
        "max_amount": 50000000,
        "selfie_with_passport":"data:image/jpeg;base64,"+ (selfie_with_passport ?? ""),
        "IdentificationVideoBase64": IdentificationVideoBase64 == null ? null : "data:image/jpeg;base64,"+ IdentificationVideoBase64 ,
        "cardNumber": cardNumber,
        "birthDate": birthDate
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.UpdateApp3);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        UpdateApp3SuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateApp3ErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
