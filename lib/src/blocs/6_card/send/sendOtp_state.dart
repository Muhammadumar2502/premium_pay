abstract class CardSendOtpState {}

class CardSendOtpIntialState extends CardSendOtpState {}

class CardSendOtpWaitingState extends CardSendOtpState {}

class CardSendOtpSuccessState extends CardSendOtpState {
  final data;
  CardSendOtpSuccessState({required this.data,});
}

class CardSendOtpErrorState extends CardSendOtpState {
  String? title;
  String? message;
  CardSendOtpErrorState({required this.message, required this.title});
}
