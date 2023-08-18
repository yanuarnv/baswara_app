import 'dart:io';

import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeUser/data/data_sources/home_user_remote_datasources.dart';
import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/exceptions.dart';
import '../../../core/network_info.dart';
import '../../../homeAdmin/data/data_sources/admin_remote_datasources.dart';
import '../../domain/entities/home_user_entity.dart';

class HomeUserRepositoryImpl extends HomeUserRepository {
  final NetworkInfo networkInfo;
  final HomeUserRemoteDataSources remoteDataSources;

  HomeUserRepositoryImpl(this.networkInfo, this.remoteDataSources);

  @override
  Future<Either<Failure, HomeUserEntity>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.getUserProfile();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(
      {required String name,
      required String noHp,
      required String email,
      required File? image}) async{
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSources.updateUserProfile(name: name, noHp: noHp, email: email, image: image);
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(InternalFailure());
    }
  }
}
