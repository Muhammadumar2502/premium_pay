abstract class GetAppsState {}

class GetAppsIntialState extends GetAppsState {}

class GetAppsWaitingState extends GetAppsState {}

class GetAppsSuccessState extends GetAppsState {
  List apps;
  GetAppsSuccessState({required this.apps});
}

class GetAppsErrorState extends GetAppsState {
  String? title;
  String? message;
  int? statusCode;
  GetAppsErrorState(
      {required this.message, required this.title, required this.statusCode});
}
