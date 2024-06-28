abstract class LoginState {}

class LoginIntialState extends LoginState {}

class LoginWaitingState extends LoginState {}

class LoginSuccessState extends LoginState {
  Map? user;
  String? token;
  LoginSuccessState({required this.user, required this.token});
}

class LoginErrorState extends LoginState {
  String? title;
  String? message;
  LoginErrorState({required this.message, required this.title});
}
