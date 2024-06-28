abstract class UpdateApp5State {}

class UpdateApp5IntialState extends UpdateApp5State {}

class UpdateApp5WaitingState extends UpdateApp5State {}

class UpdateApp5SuccessState extends UpdateApp5State {
  final data;
  UpdateApp5SuccessState({required this.data});
}

class UpdateApp5ErrorState extends UpdateApp5State {
  String? title;
  String? message;
  int? statusCode;
  UpdateApp5ErrorState(
      { this.message,  this.title,  this.statusCode});
}
