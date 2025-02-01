import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:shop_app/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/cubits/register_cubit/register_cubit.dart';
import 'package:shop_app/features/authentications/login_screen.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/features/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  final loginCubit = LoginCubit();
  loginCubit.loadEmail(); // loading email when the user app statup

  //
  final checkLogin = await SharedPreferences.getInstance();
  final bool isLogin = checkLogin.getBool('isLoggedIn') ?? false;
  //
  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({super.key, required this.isLogin});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ChatCubit()..fetchMessages())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLogin ? ChatScreen() : const LoginScreen(),
      ),
    );
  }
}
