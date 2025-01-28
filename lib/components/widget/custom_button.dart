import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.child,
  });
  final void Function()? onPressed;
  final String? name;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF168ff8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: child ??
          Text(name ?? '',
              style: const TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
