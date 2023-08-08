part of 'onboarding_bloc.dart';

abstract class OnBoardingState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnBoardingInitial extends OnBoardingState {}

class SuccesOnBoardingState extends OnBoardingState {
  final String role;

  SuccesOnBoardingState({required this.role});

}

class FailureOnBoardingState extends OnBoardingState{}
