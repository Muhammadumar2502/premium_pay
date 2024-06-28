import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';
import 'update.2.state.dart';

class UpdateApp2Bloc extends Cubit<UpdateApp2State> {
  DioClient dioClient = DioClient();
  UpdateApp2Bloc() : super(UpdateApp2IntialState());

  Future post({
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
    emit(UpdateApp2WaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    print(id);
    dio.Response response = await dioClient.post(
      Endpoints.UpdateApp2,
      data: {
        "id": id,
        "phoneNumber": phoneNumber,
        "phoneNumber2": phoneNumber2,
        "cardNumber": cardNumber,
        "passport_by":passport_by,
        "passport_date":passport_date,
        "address":address,
        "region_id" : region_id,
        "cardId" :cardId
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.UpdateApp2);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        UpdateApp2SuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateApp2ErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
