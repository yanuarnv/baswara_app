import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/core/exceptions.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/data/data_sources/admin_remote_datasources.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
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
  Future<Either<Failure, List<User>>> getAllUser() async{
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
}
