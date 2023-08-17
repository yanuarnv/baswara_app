import 'dart:async';

import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_user_event.dart';

part 'home_user_state.dart';

class HomeUserBloc extends Bloc<HomeUserEvent, HomeUserState> {
  final HomeUserRepository repository;

  HomeUserBloc(this.repository) : super(HomeUserInitial()) {
    on<GetUserProfile>(getUserProfielMapToState);
  }

  FutureOr<void> getUserProfielMapToState(
      GetUserProfile event, Emitter<HomeUserState> emit) async {
    emit(LoadingHomeUserState());
    final data = await repository.getUserProfile();
    data.fold((l) {
      if (l is ServerFailure) {
        emit(FailureHomeUserState(l.msg));
      }
      if (l is InternalFailure) {
        emit(NoInternetHomeUser());
      }
    }, (r) => emit(SuccesGetProfile(r)));
  }
}
