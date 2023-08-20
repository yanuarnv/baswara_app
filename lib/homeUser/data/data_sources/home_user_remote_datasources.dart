import 'dart:convert';
import 'dart:io';

import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:baswara_app/homeUser/domain/entities/catalog_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant_value.dart';
import '../../../core/exceptions.dart';
import '../../../core/local_auth_storage.dart';
import '../../domain/entities/home_user_entity.dart';

abstract class HomeUserRemoteDataSources {
  Future<HomeUserEntity> getUserProfile();
  Future<CatalogEntity> getCatalogUser();

  Future<bool> updateUserProfile({required String name,
    required String noHp,
    required String email,
    required File? image});
}

class HomeUserREmoteDataSourcesImpl extends HomeUserRemoteDataSources {
  final http.Client client;

  HomeUserREmoteDataSourcesImpl(this.client);

  @override
  Future<HomeUserEntity> getUserProfile() async {
    final String token = await LocalAuthStorage().read("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var request = await http.get(
      Uri.parse('${ConstantValue.apiUrl}user'),
      headers: headers,
    );

    if (request.statusCode == 200) {
      final model = homeUserEntityFromJson(request.body);
      return model;
    } else {
      throw ServerException(request.reasonPhrase.toString());
    }
  }

  @override
  Future<bool> updateUserProfile({required String name,
    required String noHp,
    required String email,
    required File? image}) async {
    final String token = await LocalAuthStorage().read("token");

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ConstantValue.apiUrl}user'),
    );

    // Add file to the request
    if(image!=null){
      File imageFile = image;
      request.files.add(
        http.MultipartFile(
          'file', // Field name in the API
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: 'image.jpg',
        ),
      );
    }
    request.fields.addAll({
      'phone': noHp,
      'name': name,
      'email': email,
    });
    request.headers.addAll(headers);

    // Send the request and handle the response
    var response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }

  @override
  Future<CatalogEntity> getCatalogUser() async{
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
}
