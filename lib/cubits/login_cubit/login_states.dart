import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final User user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginStates {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}
