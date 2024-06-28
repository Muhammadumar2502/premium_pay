abstract class MyidState {}

class MyidIntialState extends MyidState {}

class MyidWaitingState extends MyidState {}

class MyidSuccessState extends MyidState {
  final data;
  MyidSuccessState({required this.data});
}

class MyidErrorState extends MyidState {
  String? title;
  String? message;
  int? statusCode;
  MyidErrorState(
      {required this.message, required this.title, required this.statusCode});
}
