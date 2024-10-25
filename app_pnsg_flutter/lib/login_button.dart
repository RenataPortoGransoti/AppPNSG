import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final double topPadding;
  final VoidCallback onPressed;
  final String buttonText;

  const LoginButton({super.key, 
    this.topPadding = 26.0,
    required this.onPressed,
    this.buttonText = "Login",
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPadding,
      right: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
