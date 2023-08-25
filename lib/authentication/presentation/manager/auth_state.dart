part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class SuccesLogout extends AuthState {}

class SuccessAuthState extends AuthState {
  final String role;

  SuccessAuthState({required this.role});
}

class LoadingAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final String msg;

  FailureAuthState(this.msg);
}

class SuccesCheckEmail extends AuthState {}

class SuccessCheckOtp extends AuthState {}

class NoConnectionState extends AuthState {}
