

import 'dart:convert';

import '../../../authentication/domain/entities/user_entity.dart';

AllUserEntity allUserEntityFromJson(String str) =>
    AllUserEntity.fromJson(json.decode(str));

String allUserEntityToJson(AllUserEntity data) => json.encode(data.toJson());

class AllUserEntity {
  int code;
  String status;
  String message;
  List<User> data;

  AllUserEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllUserEntity.fromJson(Map<String, dynamic> json) => AllUserEntity(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<User>.from((json["data"]).map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((e) => e.toJson()))
      };
}
