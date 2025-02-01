import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/cubits/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  String? _email; // Store email locally

  Future<User?> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

      _email = email; // Save email locally

      emit(LoginSuccess(userCredential.user!));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message!));
      return null;
    }
  }

  void loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email'); // Load email when app starts
  }

  String? getEmail() {
    return _email; // Return stored email synchronously
  }
}
