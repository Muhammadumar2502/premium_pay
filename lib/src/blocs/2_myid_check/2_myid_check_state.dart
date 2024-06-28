abstract class MyidCheckState {}

class MyidCheckIntialState extends MyidCheckState {}

class MyidCheckWaitingState extends MyidCheckState {}

class MyidCheckSuccessState extends MyidCheckState {
  final data;
  MyidCheckSuccessState({required this.data});
}

class MyidCheckErrorState extends MyidCheckState {
  String? title;
  String? message;
  int? statusCode;
  MyidCheckErrorState(
      {required this.message, required this.title, required this.statusCode});
}
