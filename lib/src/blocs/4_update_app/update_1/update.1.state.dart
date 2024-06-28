abstract class UpdateApp1State {}

class UpdateApp1IntialState extends UpdateApp1State {}

class UpdateApp1WaitingState extends UpdateApp1State {}

class UpdateApp1SuccessState extends UpdateApp1State {
  final data;
  UpdateApp1SuccessState({required this.data});
}

class UpdateApp1ErrorState extends UpdateApp1State {
  String? title;
  String? message;
  int? statusCode;
  UpdateApp1ErrorState(
      { this.message,  this.title,  this.statusCode});
}
