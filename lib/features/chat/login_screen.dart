import 'package:flutter/material.dart';
import 'package:shop_app/components/widget/custom_button.dart';
import 'package:shop_app/components/widget/custom_text_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObsured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
            const CustomTextFormField(
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              hintText: "Email",
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              isPassword: isObsured ? true : false,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObsured = !isObsured;
                  });
                },
                icon: Icon(isObsured ? Icons.visibility_off : Icons.visibility),
              ),
              prefixIcon: const Icon(Icons.password),
              labelText: "Password",
              hintText: "Password",
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
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
                    onPressed: () {},
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Color(0xFF4591cb)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
