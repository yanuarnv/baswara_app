// To parse this JSON data, do
//
//     final riwayatEntity = riwayatEntityFromJson(jsonString);

import 'dart:convert';

RiwayatEntity riwayatEntityFromJson(String str) =>
    RiwayatEntity.fromJson(json.decode(str));

String riwayatEntityToJson(RiwayatEntity data) => json.encode(data.toJson());

class RiwayatEntity {
  int code;
  String status;
  String message;
  List<DataRiwayat> data;

  RiwayatEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory RiwayatEntity.fromJson(Map<String, dynamic> json) => RiwayatEntity(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<DataRiwayat>.from(
            json["data"].map((x) => DataRiwayat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataRiwayat {
  int id;
  int usersId;
  int totalPrice;
  String status;
  double quantity;
  List<Item> items;
  DateTime createdAt;

  DataRiwayat({
    required this.id,
    required this.quantity,
    required this.usersId,
    required this.createdAt,
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  factory DataRiwayat.fromJson(Map<String, dynamic> json) => DataRiwayat(
        id: json["id"],
        usersId: json["users_id"],
        totalPrice: json["total_price"],
        status: json["status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        quantity: json["quantity"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "users_id": usersId,
        "total_price": totalPrice,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}

class Item {
  int id;
  int usersId;
  int productsId;
  int transactionsId;
  int quantity;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  Item({
    required this.id,
    required this.usersId,
    required this.productsId,
    required this.transactionsId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json["id"],
      usersId: json["users_id"],
      productsId: json["products_id"],
      transactionsId: json["transactions_id"],
      quantity: json["quantity"],
      price: json["price"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "users_id": usersId,
        "products_id": productsId,
        "transactions_id": transactionsId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
