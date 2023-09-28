import 'dart:io';

import 'package:baswara_app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, String>> register(
    String name,
    String email,
    String password,
    String phoneNumber,
    File? image,
    String rt,
    String rw,
    String desa,
  );

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, bool>> postOtpEmail(String email);

  Future<Either<Failure, bool>> postOtpAuth(String email, String otp);

  Future<Either<Failure, bool>> resetPasswrod(
      String email, String otp, String password);
}
