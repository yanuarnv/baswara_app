import 'dart:async';

import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/admin_repository.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository repository;

  AdminBloc(this.repository) : super(AdminInitial()) {
    on<GetProduct>(getProductMapToState);
  }

  FutureOr<void> getProductMapToState(
      GetProduct event, Emitter<AdminState> emit) async {
    emit(LoadingGetProduct());
    final data = await repository.getProduct();
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(FailureAdminState(l.msg));
        }
        if (l is InternalFailure) {
          emit(NoConnection());
        }
      },
      (r) => emit(
        SuccesGetProduct(r),
      ),
    );
  }
}
