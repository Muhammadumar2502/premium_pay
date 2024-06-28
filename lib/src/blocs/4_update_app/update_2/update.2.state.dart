abstract class UpdateApp2State {}

class UpdateApp2IntialState extends UpdateApp2State {}

class UpdateApp2WaitingState extends UpdateApp2State {}

class UpdateApp2SuccessState extends UpdateApp2State {
  final data;
  UpdateApp2SuccessState({required this.data});
}

class UpdateApp2ErrorState extends UpdateApp2State {
  String? title;
  String? message;
  int? statusCode;
  UpdateApp2ErrorState(
      { this.message,  this.title,  this.statusCode});
}
