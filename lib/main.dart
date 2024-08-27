import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_note/bloc/auth_bloc.dart';
import 'package:flutter_firebase_note/auth/auth_listener.dart';
import 'package:flutter_firebase_note/core/theme_dark_mode.dart';
import 'package:flutter_firebase_note/core/theme_light_mode.dart';
import 'package:flutter_firebase_note/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return BlocProvider(
      create: (context) => AuthBloc(firebaseAuth),
      child: MaterialApp(
          title: 'Flutter Firestore Note',
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          home: const AuthListener()),
    );
  }
}
