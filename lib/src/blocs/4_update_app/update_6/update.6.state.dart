abstract class UpdateApp6State {}

class UpdateApp6IntialState extends UpdateApp6State {}

class UpdateApp6WaitingState extends UpdateApp6State {}

class UpdateApp6SuccessState extends UpdateApp6State {
  final data;
  UpdateApp6SuccessState({required this.data});
}

class UpdateApp6ErrorState extends UpdateApp6State {
  String? title;
  String? message;
  int? statusCode;
  UpdateApp6ErrorState(
      { this.message,  this.title,  this.statusCode});
}
