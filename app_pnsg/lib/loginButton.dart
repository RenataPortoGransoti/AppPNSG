import 'package:flutter/material.dart';
import 'Screens/login.dart';

class LoginButton extends StatelessWidget {
  final double topPadding;
  final VoidCallback onPressed;
  final String buttonText;

  LoginButton({
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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
