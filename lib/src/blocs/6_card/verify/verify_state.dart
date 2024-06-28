abstract class CardVerifyState {}

class CardVerifyIntialState extends CardVerifyState {}

class CardVerifyWaitingState extends CardVerifyState {}

class CardVerifySuccessState extends CardVerifyState {
  final data;
  CardVerifySuccessState({required this.data,});
}

class CardVerifyErrorState extends CardVerifyState {
  String? title;
  String? message;
  CardVerifyErrorState({required this.message, required this.title});
}
