import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';
import '../../core/network/dio_Client.dart';
import '1_login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  DioClient dioClient = DioClient();
  LoginBloc() : super(LoginIntialState());

  Future post(
      {required String loginName, required String loginPassword}) async {
    emit(LoginWaitingState());
    dio.Response response = await dioClient.post(
      Endpoints.login,
      data: {'loginName': loginName, 'loginPassword': loginPassword},
    );
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      if (response.data["data"]["role"] != "User") {
        emit(
          LoginErrorState(
              title: "AuthorizationError",
              message: "Invalid login credentials!"),
        );
      } else {
        emit(
          LoginSuccessState(
              user: response.data["data"], token: response.data["token"]),
        );
      }
    } else {
      emit(
        LoginErrorState(
            title: response.data["name"], message: response.data["message"]),
      );
    }

    return response.data;
  }
}
