import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';
import '../../core/network/dio_Client.dart';
import '../../services/storage/cache_service.dart';
import '3_get_apps_state.dart';

class GetAppsBloc extends Cubit<GetAppsState> {
  DioClient dioClient = DioClient();
  GetAppsBloc() : super(GetAppsIntialState());

  Future get() async {
    emit(GetAppsWaitingState());
    String? token = await CacheService.read(
      CacheService.token,
    );

    dio.Response response = await dioClient.get(
      Endpoints.getApps,
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        GetAppsSuccessState(
          apps: response.data["data"],
        ),
      );
    } else {
      emit(
        GetAppsErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }

    return response.data;
  }

  Future refresh() async {
    String? token = await CacheService.read(
      CacheService.token,
    );

    dio.Response response = await dioClient.get(
      Endpoints.getApps,
      options: dio.Options(
        headers: {
          "Authorization": "Bearer " + (token ?? ""),
        },
      ),
    );
    print(">>>>>>>>>>>> zayavkalar");
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      emit(
        GetAppsSuccessState(
          apps: response.data["data"] ,
        ),
      );
    } else {
      emit(
        GetAppsErrorState(
          title: response.data["name"],
          message: response.data["message"],
          statusCode: response.statusCode,
        ),
      );
    }
    return response.data;
  }

  add() {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;
      apps.add(
        {
        "id": null,
        "merchant_id": null,
        "user_id": null,
        "fullname": null,
        "phoneNumber": null,
        "phoneNumber2": null,
        "cardNumber": null,
        "passport": null,
        "status": null,
        "canceled_reason": null,
        "device": null,
        "location": null,
        "products": null,
        "amount": null,
        "payment_amount": null,
        "expired_month": null,
        "created_time": null,
        "finished_time": null,
        "bank": 'Davr',
        "selfie": null,
        "agree": null,
        "step": 0,
        "myidInfo": null,
        "limit_summa":null
      });
     
      emit(GetAppsSuccessState(apps: apps));
    }

    //  emit(state);
  }

  update1({Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;
      apps.last = app;
      emit(GetAppsSuccessState(apps: apps));
    }
  }

  update2({String? id,Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;
      if (id == null) {
        apps.last = app;
      } else {
        apps[apps.indexWhere((element) => element["id"].toString() == id)]
             = app;
      }
      emit(GetAppsSuccessState(apps: apps));
    }
  }

  update3({String? id,Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;
      if (id == null) {
        apps.last = app;
        emit(GetAppsSuccessState(apps: apps));
      } else {
        apps[apps.indexWhere((element) => element["id"].toString() == id)]
             = app;
      }
      emit(GetAppsSuccessState(apps: apps));
    }
  }

  update5({String? id,double? total,Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;

      if (id == null) {
        apps.last = app;
        apps.last["amount"] = total;
      } else {
        apps[apps.indexWhere((element) => element["id"].toString() == id)]
             = app;

             apps[apps.indexWhere((element) => element["id"].toString() == id)]
            ["amount"] =total;
      }
      emit(GetAppsSuccessState(apps: apps));
    }
  }

  update6({String? id,Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;

      if (id == null) {
        apps.last = app;
      } else {
        apps[apps.indexWhere((element) => element["id"].toString() == id)]
             = app;
      }
      emit(GetAppsSuccessState(apps: apps));
    }
  }

  update7({String? id,Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;

      if (id == null) {
        apps.last = app;
      } else {
        apps[apps.indexWhere((element) => element["id"].toString() == id)]
             = app;
      }
      emit(GetAppsSuccessState(apps: apps));
    }
  }

  updateFinish({String? id,Map? app}) {
    if (state is GetAppsSuccessState) {
      final apps = (state as GetAppsSuccessState).apps;

      if (id == null) {
        apps.last = app;
      } else {
        apps[apps.indexWhere((element) => element["id"].toString() == id)]
             = app;
      }
      emit(GetAppsSuccessState(apps: apps));
    }
  }
}
