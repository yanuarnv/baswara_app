// To parse this JSON data, do
//
//     final categoryEntity = categoryEntityFromJson(jsonString);

import 'dart:convert';

CategoryEntity categoryEntityFromJson(String str) =>
    CategoryEntity.fromJson(json.decode(str));

String categoryEntityToJson(CategoryEntity data) => json.encode(data.toJson());

class CategoryEntity {
  int code;
  String status;
  String message;
  List<DataCategory> data;

  CategoryEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<DataCategory>.from(
            json["data"].map((x) => DataCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataCategory {
  final int id;
  final String name;

  final List<ProductCategory> products;

  DataCategory({
    required this.id,
    required this.name,
    required this.products,
  });

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        id: json["id"],
        name: json["name"],
        products: json["products"] == null
            ? []
            : List<ProductCategory>.from(
                json["products"]!.map((x) => ProductCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": products,
      };
}

class ProductCategory {
  int id;
  String name;

  int? categoriesId;

  ProductCategory({
    required this.id,
    required this.name,
    this.categoriesId,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        categoriesId: json["categories_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categories_id": categoriesId,
      };
}
