part of 'home_user_bloc.dart';

abstract class HomeUserState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeUserInitial extends HomeUserState {}

class SuccesGetProfile extends HomeUserState {
  final HomeUserEntity model;

  SuccesGetProfile(this.model);
}

class LoadingHomeUserState extends HomeUserState {}

class NoInternetHomeUser extends HomeUserState{}

class FailureHomeUserState extends HomeUserState {
  final String msg;

  FailureHomeUserState(this.msg);
}