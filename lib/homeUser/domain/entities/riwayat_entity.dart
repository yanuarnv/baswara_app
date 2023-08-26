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
  List<dynamic> items;

  DataRiwayat({
    required this.id,
    required this.usersId,
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  factory DataRiwayat.fromJson(Map<String, dynamic> json) => DataRiwayat(
        id: json["id"],
        usersId: json["users_id"],
        totalPrice: json["total_price"],
        status: json["status"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "users_id": usersId,
        "total_price": totalPrice,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}
