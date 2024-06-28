import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';
import 'cancel_by_client.state.dart';

class CancelByClientBloc extends Cubit<CancelByClientState> {
  DioClient dioClient = DioClient();
  CancelByClientBloc() : super(CancelByClientIntialState());

  Future post({
     required String? id,
    required String? canceled_reason,
  }) async {
    emit(CancelByClientWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    dio.Response response = await dioClient.post(
      Endpoints.CancelByClient,
      data: {
        "id":id,
        "canceled_reason": canceled_reason
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.CancelByClient);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        CancelByClientSuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        CancelByClientErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
