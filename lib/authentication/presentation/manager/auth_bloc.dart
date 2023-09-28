import 'dart:async';
import 'dart:io';

import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<RegisterAuth>(registermapToState);
    on<LoginAuth>(loginMapToState);
    on<Logout>(logoutMapToState);
    on<PostOtpEmailAuth>(postOtpEmailMapToState);
    on<PostOtpAuth>(postOtpAuthMapToState);
    on<ResetPassword>(resetPasswordMapToState);
  }

  FutureOr<void> registermapToState(
      RegisterAuth event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    final data = await repository.register(
      event.name,
      event.email,
      event.password,
      event.phoneNumber,
      event.image,
      event.rt,
      event.rw,
      event.desa,
    );
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureAuthState(l.msg));
      }
    }, (r) => emit(SuccessAuthState(role: r)));
  }

  FutureOr<void> loginMapToState(
      LoginAuth event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    final data = await repository.login(event.email, event.password);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureAuthState(l.msg));
      }
      if (l is InternalFailure) {
        emit(NoConnectionState());
      }
    }, (r) => emit(SuccessAuthState(role: r)));
  }

  FutureOr<void> logoutMapToState(Logout event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    final data = await repository.logout();
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureAuthState(l.msg));
      }
      if (l is InternalFailure) {
        emit(NoConnectionState());
      }
    }, (r) => emit(SuccesLogout()));
  }

  FutureOr<void> postOtpEmailMapToState(
      PostOtpEmailAuth event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    final data = await repository.postOtpEmail(event.email);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureAuthState(l.msg));
      }
      if (l is InternalFailure) {
        emit(NoConnectionState());
      }
    }, (r) => emit(SuccesCheckEmail()));
  }

  FutureOr<void> postOtpAuthMapToState(
      PostOtpAuth event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    final data = await repository.postOtpEmail(event.email);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureAuthState(l.msg));
      }
      if (l is InternalFailure) {
        emit(NoConnectionState());
      }
    }, (r) => emit(SuccessCheckOtp()));
  }

  FutureOr<void> resetPasswordMapToState(
      ResetPassword event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    final data =
        await repository.resetPasswrod(event.email, event.otp, event.password);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureAuthState(l.msg));
      }
      if (l is InternalFailure) {
        emit(NoConnectionState());
      }
    }, (r) => emit(SuccesResetPassword()));
  }
}
