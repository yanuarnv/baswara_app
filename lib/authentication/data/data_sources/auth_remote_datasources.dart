import 'dart:convert';

import 'package:baswara_app/core/constant_value.dart';
import 'package:http/http.dart' as http;

import '../../../core/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<bool> login(String email, String password);

  Future<bool> register(
      String name, String email, String password, String phoneNumber);
}

class AuthRemoteDataSourcesImpl extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourcesImpl(this.client);

  @override
  Future<bool> login(String email, String password) async {
    final body = {"password": password, "email": email};
    final response = await client.post(
        Uri.parse("${ConstantValue.apiUrl}login"),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> register(String name, String email, String password, String phoneNumber) async{
    final body = {
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'password': password,
    };
    final response = await client.post(
        Uri.parse("${ConstantValue.apiUrl}register"),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }
}
