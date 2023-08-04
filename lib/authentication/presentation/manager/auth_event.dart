part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginAuth extends AuthEvent {}

class RegisterAuth extends AuthEvent {
  final String name;
  final int phoneNumber;
  final String username;
  final String email;
  final String password;

  RegisterAuth(
      this.name, this.phoneNumber, this.username, this.email, this.password);
}

