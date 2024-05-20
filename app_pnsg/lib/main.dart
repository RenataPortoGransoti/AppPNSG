import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appPNSG.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isLoggedIn = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.get('token') != null) {
    isLoggedIn = true;
  }
  runApp(appPNSG(isLoggedIn));
}
