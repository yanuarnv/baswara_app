import 'dart:async';
import 'dart:io';

import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../homeUser/domain/entities/catalog_entity.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/repositories/admin_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository repository;

  AdminBloc(this.repository) : super(AdminInitial()) {
    on<GetProduct>(getProductMapToState);
    on<AddProduct>(addProductMapToState);
    on<GetReport>(getReportMapToState);
    on<DeleteCatalogAdmin>(deleteCatalogAdminMapToState);
    on<DeleteProduct>(deleteProductMapToState);
    on<AddCatalogAdmin>(addCatalogAdminMapToState);
    on<GetAlluser>(getAllUserMapToState);
    on<TarikSaldoUser>(tarikSaldoUserMapToState);
    on<EditCatalogAdmin>(editCatalogAdminMapToState);
    on<GetAllCategory>(getAllCategoryMapToState);
    on<GetCatalogAdmin>(getCatalogAdminMapToState);
    on<PostCheckOut>(postCheckoutMapToState);
    on<UpdateHargaSampah>(updateHargaSampahMapToState);
  }

  FutureOr<void> getProductMapToState(
      GetProduct event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
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

  FutureOr<void> addProductMapToState(
      AddProduct event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.addProduct(event.name, event.category);
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
        SuccesProductCRUD(),
      ),
    );
  }

  FutureOr<void> deleteProductMapToState(
      DeleteProduct event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.deleteProduct(event.idProduct);
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
        SuccesProductCRUD(),
      ),
    );
  }

  FutureOr<void> getAllUserMapToState(
      GetAlluser event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.getAllUser();
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
        SuccesGetAllUser(r),
      ),
    );
  }

  FutureOr<void> getAllCategoryMapToState(
      GetAllCategory event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.getAllCategory();
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
        SuccesGetAllCategory(r),
      ),
    );
  }

  FutureOr<void> postCheckoutMapToState(
      PostCheckOut event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.potCheckout(event.items, event.userId);
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
        SuccesPostCheckout(),
      ),
    );
  }

  FutureOr<void> updateHargaSampahMapToState(
      UpdateHargaSampah event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.updateHargaSampah(event.items);
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
        SuccesUpdateHarga(),
      ),
    );
  }

  FutureOr<void> getCatalogAdminMapToState(
      GetCatalogAdmin event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.getCatalogAdmin();
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
        SuccesGetCatalogAdmin(r),
      ),
    );
  }

  FutureOr<void> addCatalogAdminMapToState(
      AddCatalogAdmin event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.addCatalogAdmin(
      name: event.name,
      tautan: event.tautan,
      image: event.img,
    );
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
        SuccesCatallogAdmin(),
      ),
    );
  }

  FutureOr<void> editCatalogAdminMapToState(
      EditCatalogAdmin event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.editCatalogAdmin(
      name: event.name,
      tautan: event.tautan,
      id: event.id,
      image: event.img,
    );
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
        SuccesCatallogAdmin(),
      ),
    );
  }

  FutureOr<void> deleteCatalogAdminMapToState(
      DeleteCatalogAdmin event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.deleteCatalogAdmin(event.id);
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
        SuccesCatallogAdmin(),
      ),
    );
  }

  FutureOr<void> getReportMapToState(
      GetReport event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data = await repository.getReport();
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
        SuccesGetReport(r),
      ),
    );
  }

  FutureOr<void> tarikSaldoUserMapToState(
      TarikSaldoUser event, Emitter<AdminState> emit) async {
    emit(LoadingAdminState());
    final data =
        await repository.tarikSaldoUser(event.userID, event.totalPrice);
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
        SuccesTarikSaldo(),
      ),
    );
  }
}
