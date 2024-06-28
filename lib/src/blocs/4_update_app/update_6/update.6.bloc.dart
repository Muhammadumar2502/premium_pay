import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/blocs/4_update_app/update_6/update.6.state.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';

class UpdateApp6Bloc extends Cubit<UpdateApp6State> {
  DioClient dioClient = DioClient();
  UpdateApp6Bloc() : super(UpdateApp6IntialState());

  Future post(
      {required String id,
      required double? payment_amount,
      required String? expired_month}) async {
    emit(UpdateApp6WaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    print(id);
    dio.Response response = await dioClient.post(
      Endpoints.UpdateApp6,
      data: {
        "id": id,
        "payment_amount": payment_amount,
        "expired_month": expired_month
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.UpdateApp6);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        UpdateApp6SuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateApp6ErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
