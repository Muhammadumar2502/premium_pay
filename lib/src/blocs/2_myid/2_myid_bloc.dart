import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';
import '../../core/network/dio_Client.dart';
import '../../services/storage/cache_service.dart';
import '2_myid_state.dart';

class MyidBloc extends Cubit<MyidState> {
  DioClient dioClient = DioClient();
  MyidBloc() : super(MyidIntialState());

  Future getMe({
       required String? code,
    required String? passport,
     required String? birthDate,
     required String? base64Image,
     
     
  }) async {
    emit(MyidWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    dio.Response response = await dioClient.post(
      Endpoints.myid,
      data: {'code': code,'passport': passport ,'birthDate':birthDate,'base64': "data:image/jpeg;base64,"+  base64Image!},
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(
        MyidSuccessState(
          data: response.data,
        ),
      );
    } else {
      emit(
        MyidErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }
}
