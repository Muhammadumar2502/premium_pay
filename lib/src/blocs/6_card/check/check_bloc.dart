import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_new/src/services/jwt/generate.dart';

import '../../../../export_files.dart';
import 'check_state.dart';

class CardCheckBloc extends Cubit<CardCheckState> {
  DioClient dioClient = DioClient();
  CardCheckBloc() : super(CardCheckIntialState());

  Future post({
    required String? card,
  }) async {
    emit(CardCheckWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );
    
    final data =  await JWTService.decode({'cardNumber': card});
    print(data);
    dio.Response response = await dioClient.post(
      Endpoints.cardCheck,
      data: {
        "data": data
      },
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
     emit(
          CardCheckSuccessState(
            data: data
          ),
        );
    } else {
      emit(
        CardCheckErrorState(
            title: response.data["name"], message: response.data["message"]),
      );
    }

    return response.data;
  }
}
