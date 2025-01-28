import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/widget/custom_button.dart';
import 'package:shop_app/components/widget/custom_text_filed.dart';
import 'package:shop_app/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/cubits/login_cubit/login_states.dart';
import 'package:shop_app/features/authentications/register_screen.dart';
import 'package:shop_app/features/chat/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObsured = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Success'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ChatScreen()));
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Login now to browser out hot offers",
                    style: TextStyle(
                        color: Color(0xff9c9c9c),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    prefixIcon: const Icon(Icons.email),
                    labelText: "Email",
                    hintText: "Email",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextFormField(
                    controller: _passwordController,
                    isPassword: isObsured ? true : false,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObsured = !isObsured;
                        });
                      },
                      icon: Icon(
                          isObsured ? Icons.visibility_off : Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    labelText: "Password",
                    hintText: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your password';
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomButton(
                    name: state is LoginLoading ? null : 'LOGIN',
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              BlocProvider.of<LoginCubit>(context)
                                  .login(email, password);
                            }
                          },
                    child: state is LoginLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Color(0xFF4591cb)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
