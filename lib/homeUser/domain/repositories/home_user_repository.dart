import 'package:baswara_app/core/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/home_user_entity.dart';

abstract class HomeUserRepository {
  Future<Either<Failure,HomeUserEntity>> getUserProfile();
}