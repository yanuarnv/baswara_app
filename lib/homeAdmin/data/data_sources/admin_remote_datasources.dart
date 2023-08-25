import 'dart:convert';
import 'dart:io';

import 'package:baswara_app/core/constant_value.dart';
import 'package:baswara_app/core/local_auth_storage.dart';
import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/report_entity.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../core/exceptions.dart';
import '../../../homeUser/domain/entities/catalog_entity.dart';

abstract class AdminRemoteDataSources {
  Future<List<Product>> getProduct();

  Future<ReportEntity> getReport();

  Future<bool> addProduct(String name, int category);

  Future<bool> delete(String id);

  Future<bool> deleteCatalogAdmin(String id);

  Future<bool> tarikSaldoUser(int userId, int totalSaldo);

  Future<List<Data>> getAllUser();

  Future<CatalogEntity> getCatalogAdmin();

  Future<bool> addCatalogAdmin({
    required String name,
    required String tautan,
    required File? image,
  });

  Future<bool> editCatalogAdmin({
    required String name,
    required String tautan,
    required File? image,
    required String id,
  });

  Future<List<DataCategory>> getAllCategory();

  Future<bool> postCheckout(List<Map<String, dynamic>> body);

  Future<bool> updateHargaSampah(List<Map<String, dynamic>> body);
}

class AdminRemoteDataSourcesImpl extends AdminRemoteDataSources {
  final http.Client client;

  AdminRemoteDataSourcesImpl(this.client);

  @override
  Future<List<Product>> getProduct() async {
    final request = http.MultipartRequest(
        'GET', Uri.parse('https://baswara-backend.my.id/api/products'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final streamToString = await response.stream.bytesToString();
      final data = productEntityFromJson(streamToString);
      return data.data;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> addProduct(String name, int category) async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://baswara-backend.my.id/api/products'));
    request.fields.addAll({'name': name, 'categories_id': category.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> delete(String id) async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('DELETE',
        Uri.parse('https://baswara-backend.my.id/api/products?id=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<List<Data>> getAllUser() async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://baswara-backend.my.id/api/admin'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final stream = await response.stream.bytesToString();
      final jsonD = json.decode(stream);
      final data = List<Data>.from(jsonD["data"].map((x) => Data.fromJson(x)));
      return data;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<List<DataCategory>> getAllCategory() async {
    var request = http.Request(
        'GET', Uri.parse('https://baswara-backend.my.id/api/categories'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final streamData = await response.stream.bytesToString();
      final data = categoryEntityFromJson(streamData);
      return data.data;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> postCheckout(List<Map<String, dynamic>> body) async {
    final String token = await LocalAuthStorage().read("token");
    final String userid = await LocalAuthStorage().read("id");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var request = await http.post(
      Uri.parse('https://baswara-backend.my.id/api/checkout'),
      body: jsonEncode(
          {"items": body, "user_id": int.parse(userid), "status": "PENDING"}),
      headers: headers,
    );

    if (request.statusCode == 200) {
      return true;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> updateHargaSampah(List<Map<String, dynamic>> body) async {
    final String token = await LocalAuthStorage().read("token");
    final String userid = await LocalAuthStorage().read("id");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var request = await http.post(
      Uri.parse('${ConstantValue.apiUrl}updateHarga'),
      body: jsonEncode({
        "items": body,
      }),
      headers: headers,
    );

    if (request.statusCode == 200) {
      return true;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }

  @override
  Future<CatalogEntity> getCatalogAdmin() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var request = await http.get(
      Uri.parse('${ConstantValue.apiUrl}catalog'),
      headers: headers,
    );

    if (request.statusCode == 200) {
      final model = catalogEntityFromJson(request.body);
      return model;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> addCatalogAdmin(
      {required String name,
      required String tautan,
      required File? image}) async {
    final String token = await LocalAuthStorage().read("token");

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ConstantValue.apiUrl}addCatalog'),
    );

    // Add file to the request
    if (image != null) {
      File imageFile = image;
      request.files.add(
        http.MultipartFile(
          'image', // Field name in the API
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: '${DateTime.now().toIso8601String()}.jpg',
        ),
      );
    }
    request.fields.addAll({
      'url': tautan,
      'name': name,
    });
    request.headers.addAll(headers);

    // Send the request and handle the response
    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> editCatalogAdmin(
      {required String name,
      required String tautan,
      required String id,
      required File? image}) async {
    final String token = await LocalAuthStorage().read("token");

    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type':
          'multipart/form-data; boundary=<calculated when request is sent>'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ConstantValue.apiUrl}updateCatalog?id=$id'),
    );

    // Add file to the request
    if (image != null) {
      File imageFile = image;
      request.files.add(
        http.MultipartFile(
          'image', // Field name in the API
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split("/").last,
        ),
      );
    }
    request.fields.addAll({
      'url': tautan,
      'name': name,
    });
    request.headers.addAll(headers);
    // Send the request and handle the response
    var response = await request.send();

    debugPrint(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> deleteCatalogAdmin(String id) async {
    // TODO: implement deleteCatalogAdmin
    final String token = await LocalAuthStorage().read("token");
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://baswara-backend.my.id/api/deleteCatalog?id=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<ReportEntity> getReport() async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var request = await http.get(
      Uri.parse('${ConstantValue.apiUrl}recentReports'),
      headers: headers,
    );

    if (request.statusCode == 200) {
      final model = reportEntityFromJson(request.body);
      return model;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> tarikSaldoUser(int userId, int totalSaldo) async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = {"users_id": userId, "total_price": totalSaldo};
    var request = await http.post(
        Uri.parse('${ConstantValue.apiUrl}withdrawal'),
        headers: headers,
        body: jsonEncode(body));

    if (request.statusCode == 200) {
      return true;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }
}
