import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/pages/login_page.dart';
import 'package:flutter_firebase_note/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool loginPage = true;
  void onTap() {
    setState(() {
      loginPage = !loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginPage) {
      return LoginPage(
        onTap: onTap,
      );
    }
    return RegisterPage(
      onTap: onTap,
    );
  }
}
