abstract class UpdateApp7State {}

class UpdateApp7IntialState extends UpdateApp7State {}

class UpdateApp7WaitingState extends UpdateApp7State {}

class UpdateApp7SuccessState extends UpdateApp7State {
  final data;
  UpdateApp7SuccessState({required this.data});
}

class UpdateApp7ErrorState extends UpdateApp7State {
  String? title;
  String? message;
  int? statusCode;
  UpdateApp7ErrorState(
      { this.message,  this.title,  this.statusCode});
}
