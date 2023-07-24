import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/local_auth_storage.dart';


part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnBoardingState> {
  OnboardingBloc() : super(OnBoardingInitial()) {
    on<CheckAuth>(checkAuthEventToState);
  }

  FutureOr<void> checkAuthEventToState(CheckAuth event, Emitter<OnBoardingState> emit) async{
    try {
      await LocalAuthStorage().read("token").then((value) async {
        await Future.delayed(const Duration(milliseconds: 2000));
        emit(
          SuccesOnBoardingState(),
        );
      });
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(
        FailureOnBoardingState(),
      );
    }
  }
}
