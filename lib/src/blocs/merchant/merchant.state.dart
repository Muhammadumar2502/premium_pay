abstract class MerchantState {}

class MerchantIntialState extends MerchantState {}

class MerchantWaitingState extends MerchantState {}

class MerchantSuccessState extends MerchantState {
  final data;
  MerchantSuccessState({required this.data});
}

class MerchantErrorState extends MerchantState {
  String? title;
  String? message;
  int? statusCode;
  MerchantErrorState(
      { this.message,  this.title,  this.statusCode});
}
