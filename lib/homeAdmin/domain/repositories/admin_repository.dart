import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure,List<Product>>> getProduct();
  Future<Either<Failure,bool>> addProduct(String name,int category);
}