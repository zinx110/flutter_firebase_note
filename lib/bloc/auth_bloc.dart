import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_firebase_note/models/user_model.dart";
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth;
  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<AuthRegisterRequested>(onAuthRegister);

    on<AuthLoginRequested>(onAuthLogin);

    on<AuthLogoutRequested>(onAuthLogout);
    on<AppStarted>(onAppStarted);
  }

  void onAuthRegister(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    if (state is AuthLoading) return;
    final password = event.password;
    final email = event.email;
    final name = event.name;
    final confirmPassword = event.confirmPassword;

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      emit(AuthFailure("All fields are required"));
      return;
    }
    if (password != confirmPassword) {
      emit(AuthFailure("Password do not match"));
      return;
    }
    emit(AuthLoading());
    try {
      UserCredential? userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) {
        emit(AuthFailure("Could not create Account"));
        return;
      }
      await _firebaseAuth.currentUser?.updateDisplayName(name);
      final UserModel newUser = UserModel(
          displayName: name,
          email: email,
          uid: user.uid,
          friends: [],
          friendRequests: []);
      await _userCollection.add(newUser.toMap());
      emit(AuthSuccess(
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        uid: user.uid,
      ));
      return;
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message.toString()));
      return;
    }
  }

  void onAuthLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    if (state is AuthLoading) return;
    final email = event.email;
    final password = event.password;
    if (email.isEmpty || password.isEmpty) {
      emit(AuthFailure("All fields are required"));
      return;
    }
    emit(AuthLoading());
    try {
      UserCredential? userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        emit(AuthFailure("Login failed"));
        return;
      }
      emit(AuthSuccess(
          displayName: user.displayName ?? "",
          email: user.email ?? "",
          uid: user.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message.toString()));
    }
  }

  void onAuthLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    if (state is AuthLoading) return;
    emit(AuthLoading());
    await _firebaseAuth.signOut();
    emit(AuthInitial());
  }

  void onAppStarted(AppStarted event, Emitter<AuthState> emit) {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(AuthInitial());
      return;
    }
    final email = user.email ?? "";
    final displayName = user.displayName ?? "";
    final uid = user.uid;
    emit(AuthSuccess(email: email, displayName: displayName, uid: uid));
  }
}
