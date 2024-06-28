abstract class UpdateApp3State {}

class UpdateApp3IntialState extends UpdateApp3State {}

class UpdateApp3WaitingState extends UpdateApp3State {}

class UpdateApp3SuccessState extends UpdateApp3State {
  final data;
  UpdateApp3SuccessState({required this.data});
}

class UpdateApp3ErrorState extends UpdateApp3State {
  String? title;
  String? message;
  int? statusCode;
  UpdateApp3ErrorState(
      { this.message,  this.title,  this.statusCode});
}
