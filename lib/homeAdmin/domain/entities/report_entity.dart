// To parse this JSON data, do
//
//     final reportEntity = reportEntityFromJson(jsonString);

import 'dart:convert';

ReportEntity reportEntityFromJson(String str) =>
    ReportEntity.fromJson(json.decode(str));

String reportEntityToJson(ReportEntity data) => json.encode(data.toJson());

class ReportEntity {
  int code;
  String status;
  String message;
  ReportData data;

  ReportEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportEntity.fromJson(Map<String, dynamic> json) => ReportEntity(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: ReportData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ReportData {
  int price;

  ReportData({
    required this.price,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
      };
}
