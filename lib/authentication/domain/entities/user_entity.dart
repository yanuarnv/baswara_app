// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  int code;
  String status;
  String message;
  Data data;

  UserEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String accessToken;
  String tokenType;
  User user;

  Data({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken:json["access_token"],
    tokenType: json["token_type"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String email;
  String phone;
  String roles;
  String savings;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.roles,
    required this.savings,

    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    roles: json["roles"],
    savings: json["savings"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "roles": roles,
    "savings": savings,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
