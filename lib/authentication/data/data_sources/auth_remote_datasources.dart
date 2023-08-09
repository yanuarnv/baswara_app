import 'dart:convert';

import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/core/local_auth_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);

  Future<String> register(
      String name, String email, String password, String phoneNumber);
}

class AuthRemoteDataSourcesImpl extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourcesImpl(this.client);

  @override
  Future<String> login(String email, String password) async {
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6Ik1ENWkva2lmUmZQUEh4RC8xcW45UVE9PSIsInZhbHVlIjoib0lJbzlKTzgrNlFRS1lqbEx5TFljekxlWFNJOXRTSmg0MXZ3bTRxKzUyQVpiYWtyNXZWdVJwd0E4SGljcXZrVC9kdHVzNXdEWWFJRjgrQ1hjSnl1blMrbmtZQmp1L0pta1BYNVNmanBwZ3FMR3pxNUFTVnA2azFBSUozNWhWNk0iLCJtYWMiOiI5Yzk2N2U1YjZhNTY5MmUzZjA4MTUzMjEzZGUxMjM1MzcwYTBhMmRiMDQyNDY3NWRiMGMwYjQ2Y2VkMzg2MzZkIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImxGZUJxTnRnQzlubkhia01QSzVzUHc9PSIsInZhbHVlIjoibE1NektLVWUxVUt2RFJoWitHYmdZTUZWbnZjNmlLRzRiR3h1WmVEb2ExRHduNTRBOVg4YlV5U0Q4aGFhNW15US90U2psbTVEQmRnMExLWmxsdzdXYlJtbjRYZUNOYTgvT3Z3c3FhVmpDZGgvWDV5a0FKS0tORXEyNk1xc3NTaHoiLCJtYWMiOiJkY2VjOTIzMzQwY2FhNjQzMTA5OWQ0NDVhNTBiODc2NDA1YjA1YjZkZDI0NDE1MGE0YjhiZTkzOTg4ZDBjNmIxIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://baswara-backend.my.id/api/login'));
    request.fields
        .addAll({'email': email, 'password': password});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final streamResult = await response.stream.bytesToString();
      final user = userEntityFromJson(streamResult);
      await LocalAuthStorage().write("token", user.data.accessToken);
      await LocalAuthStorage().write("role", user.data.user.roles);
      return user.data.user.roles;
    } else {
      if (response.statusCode == 500) {
        final streamResult = await response.stream.bytesToString();
        final user = jsonDecode(streamResult);
        throw ServerException(user["message"]);
      }
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<String> register(
      String name, String email, String password, String phoneNumber) async {
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6Ik1ENWkva2lmUmZQUEh4RC8xcW45UVE9PSIsInZhbHVlIjoib0lJbzlKTzgrNlFRS1lqbEx5TFljekxlWFNJOXRTSmg0MXZ3bTRxKzUyQVpiYWtyNXZWdVJwd0E4SGljcXZrVC9kdHVzNXdEWWFJRjgrQ1hjSnl1blMrbmtZQmp1L0pta1BYNVNmanBwZ3FMR3pxNUFTVnA2azFBSUozNWhWNk0iLCJtYWMiOiI5Yzk2N2U1YjZhNTY5MmUzZjA4MTUzMjEzZGUxMjM1MzcwYTBhMmRiMDQyNDY3NWRiMGMwYjQ2Y2VkMzg2MzZkIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImxGZUJxTnRnQzlubkhia01QSzVzUHc9PSIsInZhbHVlIjoibE1NektLVWUxVUt2RFJoWitHYmdZTUZWbnZjNmlLRzRiR3h1WmVEb2ExRHduNTRBOVg4YlV5U0Q4aGFhNW15US90U2psbTVEQmRnMExLWmxsdzdXYlJtbjRYZUNOYTgvT3Z3c3FhVmpDZGgvWDV5a0FKS0tORXEyNk1xc3NTaHoiLCJtYWMiOiJkY2VjOTIzMzQwY2FhNjQzMTA5OWQ0NDVhNTBiODc2NDA1YjA1YjZkZDI0NDE1MGE0YjhiZTkzOTg4ZDBjNmIxIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://baswara-backend.my.id/api/register'));
    request.fields.addAll({
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'password': password
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final streamResult = await response.stream.bytesToString();
      final user = userEntityFromJson(streamResult);
      await LocalAuthStorage().write("token", user.data.accessToken);
      await LocalAuthStorage().write("role", user.data.user.roles);
      return user.data.user.roles;
    } else {
      if (response.statusCode == 500) {
        final streamResult = await response.stream.bytesToString();
        final user = jsonDecode(streamResult);
        throw ServerException(user["message"]);
      }
      throw ServerException(response.reasonPhrase.toString());
    }
  }
}
