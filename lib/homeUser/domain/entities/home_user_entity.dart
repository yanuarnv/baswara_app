// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

HomeUserEntity homeUserEntityFromJson(String str) => HomeUserEntity.fromJson(json.decode(str));

String homeUserEntityToJson(HomeUserEntity data) => json.encode(data.toJson());

class HomeUserEntity {
  int code;
  String status;
  String message;
  Data data;

  HomeUserEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeUserEntity.fromJson(Map<String, dynamic> json) => HomeUserEntity(
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
  int id;
  String name;
  String email;
  String imageUrl;
  String phone;
  String roles;
  String savings;
  dynamic emailVerifiedAt;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  dynamic twoFactorConfirmedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> transactions;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.roles,
    required this.savings,
    required this.emailVerifiedAt,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    imageUrl: json["image_url"],
    phone: json["phone"],
    roles: json["roles"],
    savings: json["savings"],
    emailVerifiedAt: json["email_verified_at"],
    twoFactorSecret: json["two_factor_secret"],
    twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
    twoFactorConfirmedAt: json["two_factor_confirmed_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image_url": imageUrl,
    "phone": phone,
    "roles": roles,
    "savings": savings,
    "email_verified_at": emailVerifiedAt,
    "two_factor_secret": twoFactorSecret,
    "two_factor_recovery_codes": twoFactorRecoveryCodes,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "transactions": List<dynamic>.from(transactions.map((x) => x)),
  };
}
