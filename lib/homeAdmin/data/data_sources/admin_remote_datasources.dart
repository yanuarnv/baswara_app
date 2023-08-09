import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

import '../../../core/exceptions.dart';

abstract class AdminRemoteDataSources {
  Future<List<Product>> getProduct();
}

class AdminRemoteDataSourcesImpl extends AdminRemoteDataSources {
  final http.Client client;

  AdminRemoteDataSourcesImpl(this.client);

  @override
  Future<List<Product>> getProduct() async {
    final headers = {
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IjdJdnZCM3p6VTAwaVFhQ1JvWHMxOEE9PSIsInZhbHVlIjoieVRnLzBYamkybThHVmdMdjhaZ3BGeWJFR2Z5SC90Z1NUS042K1JFbEYyaHpUOTJjakpueVA0bXhWaVNsQkErMCtWcDI5QTZEU3hmSXlZWVpVaFZuMS9HdHF1eGtjV0hybHhxK0E5Z0hWUU1FMmlkSWppVVZzODdBSGtjUEFiSUYiLCJtYWMiOiJmOTI4Yjc2NDI2NWViMWNkNWI2Njk5YWZmZDIwYzVlZTE2NDFmZTlkOTg3NjkxOTZmYWI3ZDFjNjM0Yzk4MTdjIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkVkS3dLdTZUdHJXdFM1NDdWUkZsUUE9PSIsInZhbHVlIjoibTBhUTJzVXluZUpyT09tanhBdlJPTjFGMzhHeHdtMzFrMEhwejJrV1czdityUjZqcThuTnZVQmxrRnJ1RWNlbFRnQjZRZ2lVK1lWektoV1dDcm9hUjNzeEpZRVNoelpGUXhrSWw0UHRKeG1xaS9lMnNQYkRmVkJaT1QxdHNTTkwiLCJtYWMiOiIzZjBlMTRhMzY2ZGIyNmRjMDAxNGI2ZDBhNDc1MTNjZDI3NDg3YjNkOTU5MDRiMTE5MzFjNzc0YTI0OWFjOTIwIiwidGFnIjoiIn0%3D'
    };
    final request = http.MultipartRequest(
        'GET', Uri.parse('https://baswara-backend.my.id/api/products'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final streamToString = await response.stream.bytesToString();
      final data =productEntityFromJson(streamToString);
      return data.data;
    }
    else {
      throw ServerException(response.reasonPhrase.toString());
    }
  }
}
