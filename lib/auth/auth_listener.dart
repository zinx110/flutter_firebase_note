import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_note/auth/tab_page.dart';
import 'package:flutter_firebase_note/bloc/auth_bloc.dart';
import 'package:flutter_firebase_note/auth/login_or_register.dart';
import 'package:flutter_firebase_note/pages/notes_page.dart';

class AuthListener extends StatelessWidget {
  const AuthListener({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AppStarted());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AuthSuccess) {
            return const TabPage();
          }
          return const LoginOrRegister();
        },
      ),
    );
  }
}
