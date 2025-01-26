import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  Future<User?> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess(userCredential.user!));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message!));
      return null;
    }
  }
}
