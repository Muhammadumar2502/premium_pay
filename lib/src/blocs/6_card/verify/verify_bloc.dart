import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_new/src/services/jwt/generate.dart';

import '../../../../export_files.dart';
import 'verify_state.dart';

class CardVerifyBloc extends Cubit<CardVerifyState> {
  DioClient dioClient = DioClient();
  CardVerifyBloc() : super(CardVerifyIntialState());

  Future post({
    required String? id,
    required String? code,
    required String? type,
  }) async {
    emit(CardVerifyWaitingState());
    // await Future.delayed(Duration(seconds: 3));
    String? token = await CacheService.read(
      CacheService.token,
    );

    final data = await JWTService.decode({
      'code': code,
      'id': id,
      'type': type,
    });
    print(data);

    dio.Response response = await dioClient.post(
      Endpoints.cardVerify,
      data: {"data": data},
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      final data = await JWTService.encode(response.data["data"].toString());
      print(data);
      emit(
        CardVerifySuccessState(data: data),
      );
    } else {
      emit(
        CardVerifyErrorState(
            title: response.data["name"], message: response.data["message"]),
      );
    }

    return response.data;
  }

  Future setIntial() async {
    emit(CardVerifyIntialState());
  }
}
