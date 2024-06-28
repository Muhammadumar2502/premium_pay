abstract class GetPercentsState {}

class GetPercentsIntialState extends GetPercentsState {}

class GetPercentsWaitingState extends GetPercentsState {}

class GetPercentsSuccessState extends GetPercentsState {
  final data;
  GetPercentsSuccessState({required this.data});
}

class GetPercentsErrorState extends GetPercentsState {
  String? title;
  String? message;
  int? statusCode;
  GetPercentsErrorState(
      { this.message,  this.title,  this.statusCode});
}
