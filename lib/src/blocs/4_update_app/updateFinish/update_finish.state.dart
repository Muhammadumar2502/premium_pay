abstract class UpdateAppFinishState {}

class UpdateAppFinishIntialState extends UpdateAppFinishState {}

class UpdateAppFinishWaitingState extends UpdateAppFinishState {}

class UpdateAppFinishSuccessState extends UpdateAppFinishState {
  final data;
  UpdateAppFinishSuccessState({required this.data});
}

class UpdateAppFinishErrorState extends UpdateAppFinishState {
  String? title;
  String? message;
  int? statusCode;
  UpdateAppFinishErrorState(
      { this.message,  this.title,  this.statusCode});
}
