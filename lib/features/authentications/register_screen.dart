import 'package:flutter/material.dart';
import 'package:shop_app/components/widget/custom_button.dart';
import 'package:shop_app/components/widget/custom_text_filed.dart';
import 'package:shop_app/features/authentications/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey();

  bool isObsured = true;
  @override
  Widget build(BuildContext context) {
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
                "Register",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Register now to browser out hot offers",
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
                  icon:
                      Icon(isObsured ? Icons.visibility_off : Icons.visibility),
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
                name: 'REGISTER',
                onPressed: () {},
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
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color(0xFF4591cb)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
