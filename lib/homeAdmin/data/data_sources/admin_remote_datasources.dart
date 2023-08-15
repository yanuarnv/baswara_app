import 'dart:convert';

import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/core/constant_value.dart';
import 'package:baswara_app/core/local_auth_storage.dart';
import 'package:baswara_app/homeAdmin/domain/entities/alluser_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/checkout_body_entity.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

import '../../../core/exceptions.dart';

abstract class AdminRemoteDataSources {
  Future<List<Product>> getProduct();

  Future<bool> addProduct(String name, int category);

  Future<bool> delete(String id);

  Future<List<User>> getAllUser();

  Future<List<DataCategory>> getAllCategory();

  Future<bool> postCheckout(CheckoutBodyEntity body);
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
  Future<List<User>> getAllUser() async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://baswara-backend.my.id/api/admin'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final stream = await response.stream.bytesToString();
      final data = allUserEntityFromJson(stream);
      return data.data;
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
  Future<bool> postCheckout(CheckoutBodyEntity body) async {
    final String token = await LocalAuthStorage().read("token");
    final String userid = await LocalAuthStorage().read("id");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = await http.post(
      Uri.parse('https://baswara-backend.my.id/api/checkout'),
      body: jsonEncode({
        "item":body.items,
        "user_id":int.parse(userid),
        "status": "PENDING"
      }),
      headers: headers,
    );

    if (request.statusCode == 200) {
      return true;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }
}
