import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';
import 'update.5.state.dart';

class UpdateApp5Bloc extends Cubit<UpdateApp5State> {
  DioClient dioClient = DioClient();
  UpdateApp5Bloc() : super(UpdateApp5IntialState());

  Future post({
    required String id,
    required List products,
    required Map? device,
    required Map? location,
    required double amount
  }) async {
    emit(UpdateApp5WaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    print(id);
    dio.Response response = await dioClient.post(
      Endpoints.UpdateApp5,
      data: {
        "id": id,
        "products": products,
        "location": location,
        "device": device,
        "amount": amount,
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.UpdateApp5);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        UpdateApp5SuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateApp5ErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
