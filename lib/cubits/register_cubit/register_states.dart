import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  final User user;
  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterStates {
  final String errorMessage;
  RegisterFailure(this.errorMessage);
}
