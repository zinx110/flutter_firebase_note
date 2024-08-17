import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/widgets/common/my_button.dart';
import 'package:flutter_firebase_note/widgets/login_page_widgets/my_textfield_.dart';

class RegisterPage extends StatelessWidget {
  final MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => RegisterPage(),
  );
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),
              const SizedBox(height: 10),
              MyButton(text: "Register", onTap: () {}),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
