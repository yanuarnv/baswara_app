import 'package:baswara_app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, String>> register(
    String name,
    String email,
    String password,
    String phoneNumber,
  );
}
