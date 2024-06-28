import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

import '../../../core/network/dio_Client.dart';
import '../../../services/storage/cache_service.dart';
import 'update.7.state.dart';

class UpdateApp7Bloc extends Cubit<UpdateApp7State> {
  DioClient dioClient = DioClient();
  UpdateApp7Bloc() : super(UpdateApp7IntialState());

    Future post({
    required String id,
    required String? selfie,
  }) async {
    emit(UpdateApp7WaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    print(id);
    dio.FormData formData = dio.FormData.fromMap(
      {
        "id": id,
        'selfie': await dio.MultipartFile.fromFile(selfie ?? "",filename: "zayavka$id.jpg"),
      },
    );
    dio.Response response = await dioClient.post(
      Endpoints.UpdateApp7,
      // data: {
      //   "id": id,
      //   "selfie": selfie,
      // },
      options: dio.Options(
        contentType: 'multipart/form-data',
        headers: {
          'Accept': "application/json",
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
      data: formData,
    );
    print(Endpoints.UpdateApp7);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        UpdateApp7SuccessState(
          data: response.data["data"],
        ),
      );
    } else {
      emit(
        UpdateApp7ErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }

  // Future post({
  //   required String id,
  //   required String? selfie,
  // }) async {
  //   emit(UpdateApp7WaitingState());
  //   String? token = await CacheService.read(
  //     CacheService.token,
  //   );
  //   print(id);
  //   dio.FormData formData = dio.FormData.fromMap(
  //     {
  //       "id": id,
  //       'selfie': await dio.MultipartFile.fromFile(selfie ?? "",filename: "zayavka$id.jpg"),
  //     },
  //   );
  //   dio.Response response = await dioClient.post(
  //     Endpoints.UpdateApp7,
  //     // data: {
  //     //   "id": id,
  //     //   "selfie": selfie,
  //     // },
  //     options: dio.Options(
  //       contentType: 'multipart/form-data',
  //       headers: {
  //         'Accept': "application/json",
  //         "Authorization": "Bearer " + (token ?? ""),
  //       },
  //     ),
  //     data: formData,
  //   );
  //   print(Endpoints.UpdateApp7);
  //   print(response.statusCode);
  //   print(response.data);

  //   if (response.statusCode == 200) {
  //     emit(
  //       UpdateApp7SuccessState(
  //         data: response.data["data"],
  //       ),
  //     );
  //   } else {
  //     emit(
  //       UpdateApp7ErrorState(
  //         title: response.data["name"],
  //         message: response.data["message"],
  //         statusCode: response.statusCode,
  //       ),
  //     );
  //   }
  //   return response.data;
  // }
}
