import 'dart:io';

import 'package:baswara_app/core/failure.dart';
import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../homeUser/domain/entities/catalog_entity.dart';
import '../../../homeUser/domain/entities/home_user_entity.dart';
import '../entities/report_entity.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<Product>>> getProduct();

  Future<Either<Failure, ReportEntity>> getReport();

  Future<Either<Failure, bool>> tarikSaldoUser(int userId, int totalSaldo);

  Future<Either<Failure, bool>> addProduct(String name, int category);

  Future<Either<Failure, bool>> deleteProduct(String id);

  Future<Either<Failure, bool>> deleteCatalogAdmin(String id);

  Future<Either<Failure, List<Data>>> getAllUser();

  Future<Either<Failure, CatalogEntity>> getCatalogAdmin();

  Future<Either<Failure, bool>> addCatalogAdmin({
    required String name,
    required String tautan,
    required File? image,
  });

  Future<Either<Failure, bool>> editCatalogAdmin({
    required String name,
    required String tautan,
    required String id,
    required File? image,
  });

  Future<Either<Failure, List<DataCategory>>> getAllCategory();

  Future<Either<Failure, bool>> potCheckout(List<Map<String, dynamic>> body);

  Future<Either<Failure, bool>> updateHargaSampah(
      List<Map<String, dynamic>> body);
}
