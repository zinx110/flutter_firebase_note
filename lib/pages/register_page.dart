import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_note/bloc/auth_bloc.dart';
import 'package:flutter_firebase_note/widgets/common/my_button.dart';
import 'package:flutter_firebase_note/widgets/login_page_widgets/my_textfield_.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),
              const Text(
                "F L U T T E R F I R E ",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              MyTextField(hintText: "Username", controller: usernameController),
              const SizedBox(height: 10),
              MyTextField(hintText: "Email", controller: emailController),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "password",
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "confirm password",
                controller: confirmPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              MyButton(
                  text: "Register",
                  onTap: () {
                    context.read<AuthBloc>().add(AuthRegisterRequested(
                          name: usernameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          confirmPassword:
                              confirmPasswordController.text.trim(),
                        ));
                  }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
