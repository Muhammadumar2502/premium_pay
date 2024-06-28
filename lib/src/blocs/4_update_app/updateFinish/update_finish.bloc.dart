import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/blocs/4_update_app/updateFinish/update_finish.state.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';

class UpdateAppFinishBloc extends Cubit<UpdateAppFinishState> {
  DioClient dioClient = DioClient();
  UpdateAppFinishBloc() : super(UpdateAppFinishIntialState());

   Future post({
    required String id,
    required String contractPdf,
  }) async {
    emit(UpdateAppFinishWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    print(id);
    dio.Response response = await dioClient.post(
      Endpoints.UpdateAppFinish,
      data: {
        "id": id,
        "contractPdf": "data:application/pdf;base64," + contractPdf
      },
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(Endpoints.UpdateAppFinish);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        UpdateAppFinishSuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateAppFinishErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }



}
