import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';
import 'update.1.state.dart';

class UpdateApp1Bloc extends Cubit<UpdateApp1State> {
  DioClient dioClient = DioClient();
  UpdateApp1Bloc() : super(UpdateApp1IntialState());

  Future post({
     required String? fullname,
    required String? passport,
    required String? pinfl
  }) async {
    emit(UpdateApp1WaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    dio.Response response = await dioClient.post(
      Endpoints.UpdateApp1,
      data: {
        "fullname":fullname,
        "passport": passport,
        "pinfl":pinfl
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.UpdateApp1);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 201) {
      emit(
        UpdateApp1SuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateApp1ErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
