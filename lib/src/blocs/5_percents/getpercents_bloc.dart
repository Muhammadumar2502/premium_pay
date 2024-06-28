import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';
import 'package:premium_pay_new/src/core/network/dio_Client.dart';

import '../../services/storage/cache_service.dart';
import 'getpercents_state.dart';

class GetPercentsBloc extends Cubit<GetPercentsState> {
  DioClient dioClient = DioClient();
  GetPercentsBloc() : super(GetPercentsIntialState());

  Future get() async {
    emit(GetPercentsWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    Map? user = await CacheService.read(
      CacheService.user,
    );
    print(user);
    print(user?["fillial_id"]);
    dio.Response response = await dioClient.get(
      Endpoints.GetPercents+"${user?["fillial_id"].toString()}",
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.GetPercents);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        GetPercentsSuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        GetPercentsErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
