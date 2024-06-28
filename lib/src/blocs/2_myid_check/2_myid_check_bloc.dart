import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';
import '../../core/network/dio_Client.dart';
import '../../services/storage/cache_service.dart';
import '2_myid_check_state.dart';

class MyidCheckBloc extends Cubit<MyidCheckState> {
  DioClient dioClient = DioClient();
  MyidCheckBloc() : super(MyidCheckIntialState());

  Future check({
    required String passport,
    required String date,
    required String gender,
  }) async {
    emit(MyidCheckWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    dio.Response response = await dioClient.post(
      Endpoints.myidCheck,
      data: {'passport': passport , 'date':date,
        'gender':gender},
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      if (response.data["status"]) {
         emit(
        MyidCheckSuccessState(
          data: response.data,
        ),
      );
      }else{
         emit(
        MyidCheckErrorState(
          title: "My id Error",
          message: response.data["message"] ?? "some error",
          statusCode: response.statusCode ?? 500,
        ),
      );
      }
     
    } else {
      emit(
        MyidCheckErrorState(
          title: response.data["name"] ?? "some title",
          message: response.data["message"] ?? "some error",
          statusCode: response.statusCode ?? 500,
        ),
      );
    }
    return response.data;
  }
}
