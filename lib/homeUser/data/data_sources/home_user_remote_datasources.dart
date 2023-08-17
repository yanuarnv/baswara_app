import 'dart:convert';

import 'package:baswara_app/authentication/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant_value.dart';
import '../../../core/exceptions.dart';
import '../../../core/local_auth_storage.dart';
import '../../domain/entities/home_user_entity.dart';

abstract class HomeUserRemoteDataSources {
  Future<HomeUserEntity> getUserProfile();
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
}
