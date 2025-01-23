import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.onChange,
    this.controller,
    this.borderColor = Colors.grey,
    required this.labelText,
  }); // Added borderColor parameter
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChange;
  final Color borderColor; // Added borderColor property

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          onChanged: onChange,
          onSaved: onSaved,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Field cannot be empty';
            } else {
              return null;
            }
          },
          cursorColor: Colors.black,
          maxLines: maxLines,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: true,
            labelText: labelText, // Hint integrated into the border
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            border: buildBorder(borderColor),
            enabledBorder: buildBorder(borderColor),
            focusedBorder: buildBorder(const Color(0xFF478ecc)),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color), // Use color parameter
    );
  }
}
