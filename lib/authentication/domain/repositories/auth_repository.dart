import 'package:baswara_app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String email, String password);

  Future<Either<Failure, bool>> register(
    String name,
    String email,
    String password,
    int phoneNumber,
  );
}
