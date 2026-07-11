import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {}

class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmittedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterSubmittedEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}

class LogoutRequestedEvent extends AuthEvent {}
