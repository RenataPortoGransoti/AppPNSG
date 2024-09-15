import 'package:flutter/material.dart';
import 'Screens/login.dart';

class LoginButton extends StatelessWidget {
  final double topPadding;

  LoginButton({
    this.topPadding = 6.0,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
