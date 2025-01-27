import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Future<User?> login(String email, String password) async {
    emit(RegisterLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess(userCredential.user!));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(e.message!));
      return null;
    }
  }
}
