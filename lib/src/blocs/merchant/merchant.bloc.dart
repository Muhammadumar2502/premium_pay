import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';
import 'package:premium_pay_new/src/core/network/dio_Client.dart';


import '../../services/storage/cache_service.dart';
import 'merchant.state.dart';

class MerchantBloc extends Cubit<MerchantState> {
  DioClient dioClient = DioClient();
  MerchantBloc() : super(MerchantIntialState());

  Future get() async {
    emit(MerchantWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    Map? user = await CacheService.read(
      CacheService.user,
    );
    print(user);
    print(user?["age"]);
    dio.Response response = await dioClient.get(
      Endpoints.Merchant+"${user?["merchant_id"].toString()}/",

      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.Merchant);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        MerchantSuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        MerchantErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
