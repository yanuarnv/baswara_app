// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

ProductEntity productEntityFromJson(String str) => ProductEntity.fromJson(json.decode(str));

String productEntityToJson(ProductEntity data) => json.encode(data.toJson());

class ProductEntity {
  int code;
  String status;
  String message;
  List<Product> data;

  ProductEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  int id;
  String name;
  CategoriesId categoriesId;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.categoriesId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    categoriesId: CategoriesId.fromJson(json["categories_id"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "categories_id": categoriesId.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class CategoriesId {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  CategoriesId({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoriesId.fromJson(Map<String, dynamic> json) => CategoriesId(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
