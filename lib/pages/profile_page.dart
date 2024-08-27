import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Column(
        children: [
          const Center(child: Text("profile page")),
          Center(
              child: ElevatedButton(
            onPressed: () {},
            child: const Text("Settings"),
          )),
        ],
      ),
    );
  }
}
