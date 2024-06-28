abstract class CardCheckState {}

class CardCheckIntialState extends CardCheckState {}

class CardCheckWaitingState extends CardCheckState {}

class CardCheckSuccessState extends CardCheckState {
  final data;
  CardCheckSuccessState({required this.data,});
}

class CardCheckErrorState extends CardCheckState {
  String? title;
  String? message;
  CardCheckErrorState({required this.message, required this.title});
}
