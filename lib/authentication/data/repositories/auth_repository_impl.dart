import 'package:baswara_app/authentication/data/data_sources/auth_remote_datasources.dart';
import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/core/exceptions.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/core/network_info.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSources;

  AuthRepositoryImpl(this.networkInfo, this.remoteDataSources);

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        return const Right(true);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure('You are Offline !'));
    }
  }

  @override
  Future<Either<Failure, bool>> register(
      String name, String email, String password, String phoneNumber) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSources.register(name, email, password, phoneNumber);
        return  const Right(true);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure('You are Offline !'));
    }
  }
}
