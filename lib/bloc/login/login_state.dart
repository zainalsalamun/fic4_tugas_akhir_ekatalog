import '../../data/models/response/login_response_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponseModel loginResponseModel;
  LoginLoaded({required this.loginResponseModel});
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
