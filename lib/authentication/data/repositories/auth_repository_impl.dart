import 'dart:io';

import 'package:baswara_app/authentication/data/data_sources/auth_remote_datasources.dart';
import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/core/exceptions.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/core/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../../core/local_auth_storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSources;

  AuthRepositoryImpl(this.networkInfo, this.remoteDataSources);

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final role = await remoteDataSources.login(email, password);
        return Right(role);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register(
    String name,
    String email,
    String password,
    String phoneNumber,
    File? image,
    String rt,
    String rw,
    String desa,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final role = await remoteDataSources.register(
          name,
          email,
          password,
          phoneNumber,
          image,
          rt,
          rw,
          desa,
        );
        return Right(role);
      } on ServerException catch (e) {
        print("error");
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final role = await remoteDataSources.logout();
        await LocalAuthStorage().delete();
        return Right(role);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postOtpEmail(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final role = await remoteDataSources.postOtpEmail(email);
        await LocalAuthStorage().delete();
        return Right(role);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postOtpAuth(String email, String otp) async {
    if (await networkInfo.isConnected) {
      try {
        final role = await remoteDataSources.postOtpAuth(email, otp);
        await LocalAuthStorage().delete();
        return Right(role);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> resetPasswrod(
      String email, String otp, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final role =
            await remoteDataSources.resetPassword(email, otp, password);
        await LocalAuthStorage().delete();
        return Right(role);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }
}
