part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginAuth extends AuthEvent {
  final String email;
  final String password;

  LoginAuth(this.email, this.password);
}

class RegisterAuth extends AuthEvent {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;

  RegisterAuth(
      this.name, this.phoneNumber, this.email, this.password);
}

