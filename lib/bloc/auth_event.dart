part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  AuthRegisterRequested(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

final class AuthLogoutRequested extends AuthEvent {}

final class AppStarted extends AuthEvent {}
