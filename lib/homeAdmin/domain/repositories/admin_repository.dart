import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/domain/entities/alluser_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<Product>>> getProduct();

  Future<Either<Failure, bool>> addProduct(String name, int category);

  Future<Either<Failure, bool>> deleteProduct(String id);

  Future<Either<Failure, List<User>>> getAllUser();

  Future<Either<Failure, List<DataCategory>>> getAllCategory();
  Future<Either<Failure,bool>> potCheckout(List<Map<String, dynamic>>  body);
  Future<Either<Failure,bool>> updateHargaSampah(List<Map<String, dynamic>>  body);
}
