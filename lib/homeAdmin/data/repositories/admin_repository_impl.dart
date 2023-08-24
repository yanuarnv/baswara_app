import 'dart:io';

import 'package:baswara_app/core/exceptions.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/data/data_sources/admin_remote_datasources.dart';
import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/report_entity.dart';
import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeUser/domain/entities/catalog_entity.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/network_info.dart';

class AdminRepositoryImpl extends AdminRepository {
  final NetworkInfo networkInfo;
  final AdminRemoteDataSources remoteDataSources;

  AdminRepositoryImpl(this.networkInfo, this.remoteDataSources);

  @override
  Future<Either<Failure, List<Product>>> getProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.getProduct();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addProduct(String name, int category) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.addProduct(name, category);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.delete(id);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Data>>> getAllUser() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.getAllUser();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, List<DataCategory>>> getAllCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.getAllCategory();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> potCheckout(
      List<Map<String, dynamic>> body) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.postCheckout(body);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateHargaSampah(
      List<Map<String, dynamic>> body) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.updateHargaSampah(body);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, CatalogEntity>> getCatalogAdmin() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.getCatalogAdmin();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addCatalogAdmin(
      {required String name,
      required String tautan,
      required File? image}) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.addCatalogAdmin(
            name: name, image: image, tautan: tautan);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editCatalogAdmin(
      {required String name,
      required String tautan,
      required String id,
      required File? image}) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.editCatalogAdmin(
            id: id, name: name, image: image, tautan: tautan);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCatalogAdmin(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.deleteCatalogAdmin(id);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, ReportEntity>> getReport() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.getReport();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }
}
