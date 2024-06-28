abstract class CancelByClientState {}

class CancelByClientIntialState extends CancelByClientState {}

class CancelByClientWaitingState extends CancelByClientState {}

class CancelByClientSuccessState extends CancelByClientState {
  final data;
  CancelByClientSuccessState({required this.data});
}

class CancelByClientErrorState extends CancelByClientState {
  String? title;
  String? message;
  int? statusCode;
  CancelByClientErrorState(
      { this.message,  this.title,  this.statusCode});
}
